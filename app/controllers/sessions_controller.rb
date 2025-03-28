class SessionsController < DeviseTokenAuth::SessionsController
  def create
    user = User.find_by(email: params[:email])
    if user && user.valid_password?(params[:password])
      token = user.create_new_auth_token
      Rails.logger.debug "トークンは、#{token}"

      response.set_header("Set-Cookie", [
        "access-token=#{token['access-token']}; Path=/; HttpOnly; Secure; SameSite=None; Max-Age=6000",
        "client=#{token['client']}; Path=/; HttpOnly; Secure; SameSite=None; Max-Age=6000",
        "email=#{token['uid']}; Path=/; HttpOnly; Secure; SameSite=None; Max-Age=6000",
        "uid=#{user.id}; Path=/; HttpOnly; Secure; SameSite=None; Max-Age=6000",
        "token-type=Bearer; HttpOnly; Secure; SameSite=None; Path=/; Max-Age=6000"
      ])
      @current_user = user
      Rails.logger.debug "current_userは、#{@current_user}"
      render json: { data: user }, status: :ok
    else
      render json: { error: 'メールアドレスまたはパスワードが正しくありません。' }, status: :unauthorized
    end
  end

  def destroy
    if current_user
      current_user.tokens.delete(request.headers['access-token'])
      current_user.save!
    end

    response.set_header("Set-Cookie", [
      "access-token=; Path=/; HttpOnly; Secure; SameSite=None; Max-Age=0",
      "client=; Path=/; HttpOnly; Secure; SameSite=None; Max-Age=0",
      "email=; Path=/; HttpOnly; Secure; SameSite=None; Max-Age=0",
      "uid=; Path=/; HttpOnly; Secure; SameSite=None; Max-Age=0",
      "token-type=; HttpOnly; Secure; SameSite=None; Path=/; Max-Age=0"
    ])

    head :no_content
  end
end
