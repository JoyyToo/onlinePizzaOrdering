# frozen_string_literal: true
class PizzasController < ApplicationController
  before_action :set_category
  before_action :set_pizza, only: %i[show update destroy]
  before_action :verify_jwt_token, except: %i[index show]
  before_action :account_activated, except: %i[index show]
  before_action :ensure_admin!, except: %i[index show]

  swagger_controller :pizzas, 'Pizza'

  swagger_api :index do
    summary 'Get all available pizzas in category'
    param :path, :category_id, :integer, :required, 'Category ID'
    response :unauthorized
    response :bad_request
    response :not_found
  end

  swagger_api :show do
    summary 'Get details of a single pizza'
    param :path, :id, :integer, :required, 'Pizza ID'
    param :path, :category_id, :integer, :required, 'Category ID'
    response :unauthorized
    response :bad_request
    response :not_found
  end

  swagger_api :create do
    summary 'Create a new pizza'
    param :path, :category_id, :integer, :required, 'User ID'
    param :form, :quantity, :integer, :required, 'Quantity'
    response :unauthorized
    response :bad_request
  end

  swagger_api :update do
    summary 'Update single pizza status'
    param :path, :id, :integer, :required, 'Pizza ID'
    param :path, :category_id, :integer, :required, 'Category ID'
    param :form, :status, :string, :required, 'Current status'
    response :unauthorized
    response :bad_request
    response :not_found
  end

  swagger_api :destroy do
    summary 'Delete a single pizza'
    param :path, :id, :integer, :required, 'Pizza ID'
    param :path, :category_id, :integer, :required, 'Category ID'
    response :unauthorized
    response :bad_request
    response :ok
    response :not_found
  end

  # /get
  def index
    unless params[:per_page]
      params[:per_page] = 10
    end

    unless params[:page]
      params[:page] = 1
    end

    @pizzas = Pizza.where(category_id: params[:category_id]).paginate(
      page: params[:page], per_page: params[:per_page]
    )

    @all_pizza = []
    @pizzas.each do |pizza|
      @all_pizza << {
          id: pizza.id,
          name: pizza.name,
          price: pizza.price,
          ingredients: pizza.ingredients,
          image: pizza.image,
          category: {
            id: pizza.category_id,
            category_name: @pizzas.find_by!(params[:category_id]).category.name
          }
      }
    end

    if @all_pizza.count >= 1
      json_response(meta: {
                      page: params[:page].to_f,
                      limit: params[:per_page].to_f,
                      total_pages: (@pizzas.count.to_f / params[:per_page].to_f).ceil
                    },
                    data: @all_pizza)
    else
      json_response({ Message: Message.no_data }, :not_foun)
    end
  end

  # /get/#id
  def show
    json_response(@pizza)
  end

  # /post
  def create
    @pizza = Pizza.create(pizza_params)
    if @pizza.valid?
      json_response(@pizza, :created)
    else
      json_response(@pizza.errors.messages, :bad_request)
    end
  end

  # /put
  def update
    @pizza.update!(pizza_params)
    json_response({ Message: Message.updated }, :ok)
  end

  # /delete
  def destroy
    @pizza.destroy
    json_response({ Message: Message.deleted }, :ok)
  end

  private

  def pizza_params
    params.permit(:price, :name, :ingredients, :category_id, :image)
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_pizza
    @pizza = @category.pizzas.find_by(id: params[:id]) if @category
    if !@pizza
      json_response({ Message: Message.not_found }, :not_found)
    else
      @pizza
    end
  end
end
