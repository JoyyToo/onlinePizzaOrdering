class UsersController < ApplicationController
  before_action :verify_jwt_token, only: %i[change_password logout]
  before_action :account_activated, only: %i[change_password logout]
  before_action :set_user, only: %i[change_password forgot_password]

  def change_password
    @myuser = User.find(@user.id)
    @myuser.update!(user_params)
    json_response({ Message: Message.updated }, :ok)
  end

  def forgot_password
    MyMailer.forgot_email(@user).deliver
    json_response({ Message: 'Please check the link in your email to reset your password' }, :ok)
  end

  private

  def user_params
    params.permit(:password)
  end

  def forgot_params
    params.permit(:email)
  end
end
