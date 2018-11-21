class OrdersController < ApplicationController
  before_action :verify_jwt_token
  before_action :account_activated
  before_action :set_user, except: %I[index]
  before_action :set_pizza, except: %I[index]
  before_action :set_order, only: %i[show update destroy]
  before_action :ensure_admin!, except: %i[show user_orders]

  swagger_controller :orders, 'Orders'

  swagger_api :index do
    summary 'Get orders by all users for admin'
    response :unauthorized
    response :bad_request
    response :not_found
  end

  swagger_api :user_orders do
    summary 'Get all orders of a logged in user'
    response :unauthorized
    response :bad_request
    response :not_found
  end

  swagger_api :show do
    summary 'Get details of a single order'
    param :path, :id, :integer, :required, 'Order ID'
    response :unauthorized
    response :bad_request
    response :not_found
  end

  swagger_api :create do
    summary 'Make an order'
    param :path, :user_id, :integer, :required, 'User ID'
    param :path, :pizza_id, :integer, :required, 'Pizza ID'
    param :form, :quantity, :integer, :required, 'Quantity'
    response :unauthorized
    response :bad_request
  end

  swagger_api :update do
    summary 'Update single order'
    param :path, :id, :integer, :required, 'Order ID'
    param :form, :status, :string, :required, 'Current status'
    response :unauthorized
    response :bad_request
    response :not_found
  end

  swagger_api :destroy do
    summary 'Delete a single order'
    param :path, :id, :integer, :required, 'Order ID'
    response :unauthorized
    response :bad_request
    response :not_found
  end

  # /admin get all orders
  def index
    @orders = Order.all
    json_response(@orders)
  end

  def user_orders
    @orders = Order.where(user_id: @user.id)
    json_response(@orders)
  end

  # /get/#id
  def show
    @status = Order.find_by(id: params[:id]).status
    json_response({ Status: @status }, :ok)
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
    json_response({ Message: Message.updated }, :ok)
  end

  # /delete
  def destroy
    @order.destroy
    json_response({ Message: Message.deleted }, :ok)
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
