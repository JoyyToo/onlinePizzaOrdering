class CartController < ApplicationController
  before_action :set_user
  before_action :verify_jwt_token

  def index
    @carts = Cart.where(user_id: @user.id)
    @pizza = Pizza.where(id: params[:pizza_id])

    @mycart = []
    @carts.each do |cart|
      @mycart << {
          id: cart.id,
          user_id: cart.user_id,
          pizza: @pizza
      }
    end
    if @mycart.count >= 1
      json_response(@mycart)
    else
      json_response(Message: Message.no_data)
    end
  end

  # add to cart
  def create
    @cart = Cart.where(user_id: @user.id).create!(cart_params)
    json_response(@cart, :created)
  end

  def destroy
    @cart.destroy
    json_response({ Message: Message.deleted }, :ok)
  end

  private

  def cart_params
    params.permit(:pizza_id, :user_id)
  end
end
