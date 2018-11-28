module ActivateAccount

  def account_activated
    token = AuthToken.decode(params[:token])
    user_id = token.first.values[0]
    this_user = User.find(user_id)

    if this_user.activated?

    else
      json_response({ Message: 'Ensure your account is activated. Check your email for the activation link.' }, :bad_request)
    end
  end
end
