class RegistrationsController < DeviseTokenAuth::RegistrationsController
  def create
    user = User.create(name: params[:name], email: params[:email], password: params[:password])
    if user.save
      token = user.create_new_auth_token

      response.set_header("Set-Cookie", [
        "access-token=#{token['access-token']}; Path=/; HttpOnly; Secure; SameSite=None; Max-Age=86400",
        "client=#{token['client']}; Path=/; HttpOnly; Secure; SameSite=None; Max-Age=86400",
        "email=#{token['uid']}; Path=/; HttpOnly; Secure; SameSite=None; Max-Age=86400",
        "uid=#{user.id}; Path=/; HttpOnly; Secure; SameSite=None; Max-Age=86400",
        "token-type=Bearer; HttpOnly; Secure; SameSite=None; Path=/; Max-Age=86400"
      ])
      @current_user = user
      render json: { data: user }, status: :ok
    else
      render json: { error: 'アカウント登録に失敗しました。' }, status: :unprocessable_entity
    end
  end
end
