class UsersController < ApplicationController
  before_action :verify_jwt_token
  before_action :set_user

  def change_password
    @myuser = User.find(@user.id)
    @myuser.update!(user_params)
    json_response({ Message: Message.updated }, :ok)
  end

  private

  def user_params
    params.permit(:password)
  end
end
