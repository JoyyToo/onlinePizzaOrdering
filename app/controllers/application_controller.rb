class ApplicationController < ActionController::API
  include AuthToken
  include Response

  protected

  def verify_jwt_token
    head :unauthorized if request.headers['Authorization'].nil? ||
                          !AuthToken.valid?(request.headers['Authorization'].split(' ').last)
  end
end
