class Users::SessionsController < Devise::SessionsController

  respond_to :json

  # POST /resource/sign_in
  def create
    user = User.where(email: params[:email]).first
    token = JWT.encode({ user_id: user.id, email: user.email }, 'ewihufiuweghfuiew')
    render json: { user: user.email, token: token }, status: :created
  end
end
