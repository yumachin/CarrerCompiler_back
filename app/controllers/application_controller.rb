class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  wrap_parameters false

  before_action :add_params, if: :devise_controller?
  before_action :set_tokens
  # before_action :set_user
  # after_action :check

  public
  def set_user
    Rails.logger.debug "backメールアドレスは、、、#{request.headers['email']}"
    user = User.find_by(email: request.headers['email'].presence || params[:email])
    Rails.logger.debug "ユーザーは、#{user}"

    if request.headers['email'].nil?
      Rails.logger.debug "トークン切れ"
      render json: { error: 'トークン切れ' }, status: :unauthorized
      return
    end

    if user.nil?
      Rails.logger.debug "該当ユーザー無し。"
      render json: { error: '該当ユーザーが見つかりません' }, status: :not_found
      return
    end

    if request.headers['access-token'] && request.headers['client']
      token = request.headers['access-token']
      client = request.headers['client']
    end

    if BCrypt::Password.new(user.tokens[client]['token']) == token
      Rails.logger.debug "認証成功！"
      @current_user = user
    else
      Rails.logger.debug "トークンが一致しません。"
      @current_user = nil
    end
  end

  protected
  def add_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end

  private
  def set_tokens
    return unless request.headers["Cookie"].present?
    Rails.logger.debug "ヘッダーのCookieは。。。#{request.headers["Cookie"]}"
    Rails.logger.debug ""
    
    if request.headers["Cookie"].include?("access-token=") && 
      request.headers["Cookie"].include?("client=") &&
      request.headers["Cookie"].include?("email=") &&
      request.headers["Cookie"].include?("uid=") 
      request.headers['access-token'] = request.headers["Cookie"].split("access-token=")[1].split(";")[0]
      request.headers['client'] = request.headers["Cookie"].split("client=")[1].split(";")[0]
      request.headers['email'] = request.headers["Cookie"].split("email=")[1].split(";")[0]
      request.headers['uid'] = request.headers["Cookie"].split("uid=")[1].split(";")[0]
      Rails.logger.debug "requestは、#{request.headers['email']}"
      request.headers['token-type'] = request.headers["Cookie"].split("token-type=")[1].split(";")[0]
    end
  end

  # def check
  #   Rails.logger.debug "チェック開始"
  #   Rails.logger.debug "current_userは、#{@current_user}"
  #   Rails.logger.debug "request.headers['email']は、#{request.headers['email']}"
  #   Rails.logger.debug "request.headers['access-token']は、#{request.headers['access-token']}"
  #   Rails.logger.debug "request.headers['client']は、#{request.headers['client']}"
  #   Rails.logger.debug "request.headers['token-type']は、#{request.headers['token-type']}"
  #   Rails.logger.debug ""
  # end
end
