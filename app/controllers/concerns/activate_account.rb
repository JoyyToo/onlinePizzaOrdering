module ActivateAccount

  def account_activated
    if request.headers['Authorization']
      token = AuthToken.decode(request.headers['Authorization'].split(' ').last)
      user_id = token.first.values[0]
      this_user = User.find(user_id)
    else
      user = User.find_by(email: params[:email]).id
      this_user = User.find(user)
    end

    if this_user.activated?

    else
      json_response({ Message: 'Ensure your account is activated. Check your email for the activation link.' }, :bad_request)
    end
  end
end
