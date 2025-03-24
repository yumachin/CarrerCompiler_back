class Api::V1::UsersController < ApplicationController
  before_action :set_user

  def update
    uid = request.headers["uid"]
    user = User.find(uid)
    if user.update(user_params)
      render json: user, status: :ok
    else
      render json: user.errors, status: :bad_request
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
