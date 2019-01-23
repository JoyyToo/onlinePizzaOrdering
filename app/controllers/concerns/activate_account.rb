module ActivateAccount

  def account_activated
    if request.headers['Authorization']
      token = AuthToken.decode(request.headers['Authorization'].split(' ').last)
      email = token.first.values[2]
      user = User.find_by(email: email).id
    else
      user = User.find_by(email: params[:email]).id
    end
    this_user = User.find(user)

    if this_user.activated?

    else
      json_response({ Message: 'Ensure your account is activated. Check your email for the activation link.' }, :bad_request)
    end
  end
end
