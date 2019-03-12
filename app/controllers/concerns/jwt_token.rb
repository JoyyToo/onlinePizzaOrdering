 module JwtToken
  def verify_jwt_token
    if request.headers['Authorization'].nil? ||
       request.headers['Authorization'].split(' ').last.nil?
      json_response({ Message: Message.missing_token }, :unauthorized)
    elsif !AuthToken.valid?(
      request.headers['Authorization'].split(' ').last
    )
      json_response({ Message: Message.invalid_token }, :unauthorized)
    end
  end
end
