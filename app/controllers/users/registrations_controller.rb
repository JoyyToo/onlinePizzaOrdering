# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include Swagger::Docs::Methods

  swagger_controller :registrations, 'Registration'

  swagger_api :create do
    summary 'Create a new User'
    param :form, :username, :string, :required, 'Username'
    param :form, :email, :string, :required, 'Email address'
    param :form, :password, :string, :required, 'Password'
    response :bad_request
  end

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
