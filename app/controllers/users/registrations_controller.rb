# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  # POST /resource
  def create
    @user = User.create(register_params)
    if @user.valid?
      MyMailer.sample_email(@user).deliver
      json_response(user: @user, Message: 'Please check your email to verify your account')
    else
      json_response(@user.errors.messages, :bad_request)
    end
  end

  private

  def register_params
    params.permit(:email, :username, :password)
  end
end
