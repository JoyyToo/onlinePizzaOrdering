class Users::SessionsController < Devise::SessionsController

  respond_to :json

  # POST /resource/sign_in
  def create
    user = User.where(email: params[:email]).first
    token = AuthToken.issue_token(user)
    render json: { user: user.email, token: token }, status: :created
  end
end
