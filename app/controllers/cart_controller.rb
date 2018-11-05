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
end
