class OrdersController < ApplicationController
  before_action :set_pizza
  before_action :set_order, only: %i[show update destroy]

  # /get
  def index
    @orders = Order.all
    json_response(@orders)
  end

  # /get/#id
  def show
    @status = Order.find_by(id: params[:id]).status
    json_response(@status.to_json)
  end

  # /post(buy a pizza)
  def create
    @order = current_user.orders.create!(order_params)
    json_response(@order, :created)
  end

  # /put
  def update
    @order = @order.update(params.permit(:status))
    head :no_content
  end

  # /delete
  def destroy
    @order.destroy
    head :no_content
  end

  private

  def order_params
    params.permit(:quantity, :status, :pizza_id, :users_id)
  end

  def set_order
    @order = @pizza.orders.find_by!(id: params[:id]) if @pizza
  end

  def set_pizza
    @pizza = Pizza.find(params[:pizza_id])
  end
end
