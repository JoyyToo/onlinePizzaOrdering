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

  def activate_account
    if params[:token] && AuthToken.valid?(params[:token])
      @token = AuthToken.decode(params[:token])
      user_id = @token.first.values[1]
      this_user = User.find(user_id)
      if this_user.activated?
        json_response({ Message: 'Account already activated' }, :bad_request)
      else
        this_user.update_columns(activated: true, activated_at: Time.zone.now)
        json_response({ Message: Message.activated }, :ok)
      end
    else
      json_response({ Message: 'Please provide the token sent to your email' }, :bad_request)
    end
  end

  private

  def user_params
    params.permit(:password)
  end

  def forgot_params
    params.permit(:email)
  end
end
