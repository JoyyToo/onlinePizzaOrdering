# frozen_string_literal: true
class PizzasController < ApplicationController
  before_action :set_category
  before_action :set_pizza, only: %i[show update destroy]
  before_action :verify_jwt_token, except: %i[index show]
  before_action :ensure_admin!, except: %i[index show]

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

    @pizza_category = @pizzas.find_by!(params[:category_id]).category.name

    @all_pizza = []
    @pizzas.each do |pizza|
      @all_pizza << {
          id: pizza.id,
          name: pizza.name,
          price: pizza.price,
          ingredients: pizza.ingredients,
          category: {
            id: pizza.category_id,
            category_name: @pizza_category
          }
      }
    end

    json_response(meta: {
                    page: params[:page].to_f,
                    limit: params[:per_page].to_f,
                    total_pages: (@pizzas.count.to_f / params[:per_page].to_f).ceil
                  },
                  data: @all_pizza)
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
