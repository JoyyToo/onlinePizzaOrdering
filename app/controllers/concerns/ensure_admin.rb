module EnsureAdmin
  def ensure_admin!
    token = AuthToken.decode(request.headers['Authorization'].split(' ').last)
    role = token.first.values[2]
    unless role == 'admin'
      json_response({ Message: Message.unauthorized }, :unauthorized)
    end
  end
end
