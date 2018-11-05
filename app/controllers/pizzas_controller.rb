class PizzasController < ApplicationController
  before_action :set_category
  before_action :set_pizza, only: %i[show update destroy]
  before_action :verify_jwt_token, except: %i[index show]
  before_action :ensure_admin!, except: %i[index show]

  # /get
  def index
    @pizzas = Pizza.where(category_id: params[:category_id])
    json_response(@pizzas)
  end

  # /get/#id
  def show
    json_response(@pizza)
  end

  # /post
  def create
    @pizza = Pizza.create!(pizza_params)
    json_response(@pizza, :created)
  end

  # /put
  def update
    @pizza.update!(pizza_params)
    json_response(Message.updated.to_json)
  end

  # /delete
  def destroy
    @pizza.destroy
    json_response(Message.deleted.to_json)
  end

  private

  def pizza_params
    params.permit(:price, :name, :ingredients, :category_id)
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_pizza
    @pizza = @category.pizzas.find_by!(id: params[:id]) if @category
  end
end
