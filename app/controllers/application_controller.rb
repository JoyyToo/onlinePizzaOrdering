class ApplicationController < ActionController::API
  include AuthToken
  include Response

  protected

  def verify_jwt_token
    if request.headers['Authorization'].nil? || !AuthToken.valid?(
      request.headers['Authorization'].split(' ').last
    )
      json_response(Message.missing_token.to_json, :unauthorized)
    end
  end
end
