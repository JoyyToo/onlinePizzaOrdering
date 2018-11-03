# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  # POST /resource
  def create
    @user = User.create!(register_params)
    if @user.save
      json_response(@user)
    else
      json_response(@user.errors)
    end
  end

  private

  def register_params
    params.permit(:email, :username, :password)
  end
end
