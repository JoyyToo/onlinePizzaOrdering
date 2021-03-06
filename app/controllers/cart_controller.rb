class CartController < ApplicationController
  before_action :verify_jwt_token
  before_action :account_activated
  before_action :set_user
  before_action :set_cart, only: %i[destroy show]
  before_action :set_pizza, only: %i[create]

  def index
    @carts = Cart.where(user_id: @user.id)

    @mycart = []
    @carts.each do |cart|
      @mycart << {
        id: cart.id,
        user_id: cart.user_id,
        pizza_id: cart.pizza_id,
        pizza: get_pizza(Pizza.find(cart.pizza_id))
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
    @cart = Cart.where(user_id: @user.id, pizza_id: params[:id]).create!(cart_params)
    json_response(@cart, :created)
  end

  def show
    json_response(@cart)
  end

  def destroy
    @cart.destroy
    json_response({ Message: Message.deleted }, :ok)
  end

  private

  def cart_params
    params.permit(:pizza_id, :user_id)
  end

  def set_cart
    @cart = Cart.find_by(id: params[:id])
    if !@cart
      json_response({ Message: Message.not_found }, :not_found)
    else
      @cart
    end
  end

  def set_pizza
    @pizza = Pizza.find_by(id: params[:id])
    if !@pizza
      json_response({ Message: 'Pizza not found' }, :not_found)
    else
      @pizza
    end
  end

  def get_pizza(pizza)
    pizza
  end
end
