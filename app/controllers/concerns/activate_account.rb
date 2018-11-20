module ActivateAccount

  def activate_account
    token = AuthToken.decode(request.headers['Authorization'].split(' ').last)
    user_id = token.first.values[0]
    this_user = User.find(user_id)
    if this_user.activated?
      json_response({ Message: 'Account already activated' }, :bad_request)
    else
      this_user.update_columns(activated: true, activated_at: Time.zone.now)
      json_response({ Message: Message.activated }, :ok)
    end
  end

  def account_activated
    token = AuthToken.decode(request.headers['Authorization'].split(' ').last)
    user_id = token.first.values[0]
    this_user = User.find(user_id)
    if this_user.activated?

    else
      json_response({ Message: 'Ensure your account is activated. Check your email for the activation link.' }, :ok)
    end
  end
end
