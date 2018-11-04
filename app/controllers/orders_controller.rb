class OrdersController < ApplicationController
  before_action :verify_jwt_token
  before_action :set_user, except: %I[index]
  before_action :set_pizza, except: %I[index]
  before_action :set_order, only: %i[show update destroy]

  # /get
  def index
    @orders = Order.where(pizza_id: params[:pizza_id])
    json_response(@orders)
  end

  # /get/#id
  def show
    @status = Order.find_by(id: params[:id]).status
    json_response(@status.to_json)
  end

  # /post(buy a pizza)
  def create
    @order = Order.where(user_id: @user.id).create!(order_params)
    json_response(@order, :created)
  end

  # /put
  def update
    @order = @order.update(params.permit(:status))
    json_response(Message.updated.to_json)
  end

  # /delete
  def destroy
    @order.destroy
    json_response(Message.deleted.to_json)
  end

  private

  def order_params
    params.permit(:quantity, :status, :pizza_id, :user_id)
  end

  def set_order
    @order = @pizza.orders.find_by!(id: params[:id]) if @pizza
  end

  def set_pizza
    @pizza = Pizza.find_by!(params[:pizza_id])
  end

  def set_user
    token = AuthToken.decode(request.headers['Authorization'].split(' ').last)
    @user = User.find_by!(id: token.values[0])
  end
end
