class Users::SessionsController < Devise::SessionsController
  include ActivateAccount
  before_action :account_activated

  respond_to :json

  # POST /resource/sign_in
  def create
    user = User.where(email: params[:email]).first
    if user&.valid_password?(params[:password])
      token = JWT.encode(
        { user_id: user.id, email: user.email, role: user.roles }, 'ewihufiuweghfuiew')
      json_response({ email: user.email,
                      username: user.username,
                      user_id: user.id, token: token }, :created)
    else
      json_response({ Message: Message.invalid_credentials }, :bad_request)
    end
  end
end
