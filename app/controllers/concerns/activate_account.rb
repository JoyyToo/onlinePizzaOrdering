module ActivateAccount

  def account_activated
    user = User.find_by(email: params[:email]).id
    this_user = User.find(user)

    if this_user.activated?

    else
      json_response({ Message: 'Ensure your account is activated. Check your email for the activation link.' }, :bad_request)
    end
  end
end
