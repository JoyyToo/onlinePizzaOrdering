# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show destroy update]
  before_action :verify_jwt_token, except: %i[all_pizzas index]
  before_action :account_activated, except: %i[all_pizzas index]
  before_action :ensure_admin!, except: %i[all_pizzas index show]

  swagger_controller :categories, 'Categories'

  swagger_api :index do
    summary 'Get all pizza categories'
    response :bad_request
    response :not_found
  end

  swagger_api :all_pizzas do
    summary 'Get all available pizzas'
    response :bad_request
    response :not_found
  end

  swagger_api :show do
    summary 'Get single category'
    param :path, :category_id, :integer, :required, 'Category ID'
    response :bad_request
    response :not_found
  end

  swagger_api :create do
    summary 'Create a single category'
    param :header, :Authorization, :string, :required, 'To authorize the requests.' # to remove
    param :form, :name, :required, :string, 'Name'
    response :unauthorized
    response :bad_request
  end

  swagger_api :update do
    summary 'Update single category'
    param :path, :category_id, :integer, :required, 'Category ID'
    param :form, :name, :string, 'Name'
    response :unauthorized
    response :bad_request
    response :not_found
  end

  swagger_api :destroy do
    summary 'Delete a single category'
    param :path, :category_id, :integer, :required, 'Category ID'
    response :unauthorized
    response :bad_request
    response :not_found
  end

  def index
    @categories = Category.all
    json_response(@categories)
  end

  # /home
  def all_pizzas
    params[:per_page] = 10 unless params[:per_page]

    params[:page] = 1 unless params[:page]

    @pizzas = Pizza.all.paginate(
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
        category: get_category(Category.find(pizza.category_id))
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
      json_response({ Message: Message.no_data }, :not_found)
    end
  end

  def show
    json_response(@category)
  end

  def create
    @category = Category.create(category_params)
    if @category.valid?
      json_response(@category, :created)
    else
      json_response(@category.errors.messages, :bad_request)
    end
  end

  def update
    @category.update!(category_params)
    json_response({ Message: Message.updated }, :ok)
  end

  def destroy
    @category.destroy
    json_response({ Message: Message.deleted }, :ok)
  end

  private

  def category_params
    params.permit(:name)
  end

  def set_category
    @category = Category.find_by(id: params[:id])
    if !@category
      json_response({ Message: Message.not_found }, :not_found)
    else
      @category
    end
  end

  def get_category(category)
    {
      id: category.id,
      name: category.name
    }
  end
end
