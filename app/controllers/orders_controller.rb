class OrdersController < ApplicationController
  before_action :verify_jwt_token
  before_action :account_activated
  before_action :set_user, except: %I[index]
  before_action :set_pizza, except: %I[index]
  before_action :set_order, only: %i[show update]
  before_action :ensure_admin!, except: %i[show user_orders]

  # /admin get all orders
  def index
    @orders = Order.all
    if @orders.count >= 1
      json_response(@orders)
    else
      json_response({ Message: Message.no_data }, :not_found)
    end
  end

  def user_orders
    @orders = Order.where(user_id: @user.id)
    json_response(@orders)
  end

  # /get/#id
  def show
    json_response(@order, :ok)
  end

  # /post(buy a pizza)
  def create
    @order = Order.where(user_id: @user.id).create(order_params)
    if @order.valid?
      json_response(@order, :created)
    else
      json_response(@order.errors.messages, :bad_request)
    end
  end

  # /put
  def update
    @order = @order.update(params.permit(:status))
    json_response({ Message: Message.updated,
                    Status: Order.find_by(id: params[:id]).status }, :ok)
  end

  private

  def order_params
    params.permit(:quantity, :status, :pizza_id, :user_id)
  end

  def set_order
    @order = @pizza.orders.find_by(id: params[:id]) if @pizza
    if !@order
      json_response({ Message: Message.not_found }, :not_found)
    else
      @order
    end
  end

  def set_pizza
    @pizza = Pizza.find_by(params[:pizza_id])
    if !@pizza
      json_response({ Message: Message.not_found }, :not_found)
    else
      @pizza
    end
  end
end
