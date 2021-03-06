# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show destroy update]
  before_action :verify_jwt_token, except: %i[all_pizzas index]
  before_action :account_activated, except: %i[all_pizzas index]
  before_action :ensure_admin!, except: %i[all_pizzas index show]

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
      json_response(data: @all_pizza)
      # json_response(meta: {
      #                 page: params[:page].to_f,
      #                 limit: params[:per_page].to_f,
      #                 total_pages: (@pizzas.count.to_f / params[:per_page].to_f).ceil
      #               },
      #               data: @all_pizza)
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
      json_response(@category.errors.full_messages, :bad_request)
    end
  end

  def update
    if @category.update(category_params)
      json_response({ Message: Message.updated }, :ok)
    else
      json_response(@category.errors.full_messages, :bad_request)
    end
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
