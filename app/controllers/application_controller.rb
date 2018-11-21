class ApplicationController < ActionController::API
  include AuthToken
  include Response
  include JwtToken
  include EnsureAdmin
  include SetUser
  include ActivateAccount
  include Swagger::Docs::Methods
end
