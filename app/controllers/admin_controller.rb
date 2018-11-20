class AdminController < ApplicationController
  before_action :ensure_admin!, only: [:create_admin]
  before_action :verify_jwt_token, only: [:create_admin]
  before_action :account_activated
  before_action :admin_params, only: [:create_admin]
  before_action :user

  def create_admin
    @new_admin = @user.update!(admin_params)
    json_response({ Message: Message.new_admin }, :created)
  end

  private

  def admin_params
    @new_admin = params.permit(:roles)
  end

  def user
    @user = User.find_by!(id: params[:user_id])
  end
end
