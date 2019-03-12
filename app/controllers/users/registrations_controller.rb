# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  # POST /resource
  def create
    @user = User.create(register_params)
    if @user.valid?
      if ENV["RACK_ENV"] == 'development'
        user = User.find(@user.id)
        user.update_columns(activated: true, activated_at: Time.zone.now)
      else
        MyMailer.sample_email(@user).deliver
        json_response(user: @user, Message: 'Please check your email to verify your account')
      end
    else
      json_response(@user.errors.full_messages, :bad_request)
    end
  end

  private

  def register_params
    params.permit(:email, :username, :password)
  end
end
