class CartController < ApplicationController
  before_action :set_user
  before_action :verify_jwt_token

  def index
    @carts = Cart.where(user_id: @user.id)
    json_response(@carts)
  end

  # add to cart
  def create
    @cart = Cart.where(user_id: @user.id).create!(cart_params)
    json_response(@cart, :created)
  end

  private

  def cart_params
    params.permit(:pizza_id, :user_id)
  end

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
