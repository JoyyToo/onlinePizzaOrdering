module SetUser
  def set_user
    token = AuthToken.decode(request.headers['Authorization'].split(' ').last)
    @user = User.find_by(id: token.first.values[0])
    if !@user
      json_response({ Message: Message.not_found }, :not_found)
    else
      @user
    end
  end
end
