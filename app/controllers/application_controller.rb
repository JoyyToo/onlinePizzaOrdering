class ApplicationController < ActionController::API
  include AuthToken
  include Response

  protected

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

  def ensure_admin!
    token = AuthToken.decode(request.headers['Authorization'].split(' ').last)
    role = token.first.values[2]
    unless role == 'admin'
      json_response({ Message: Message.unauthorized }, :unauthorized)
    end
  end
end
