class PizzasController < ApplicationController
  before_action :set_category
  before_action :set_pizza, only: %i[show update destroy]
  skip_before_action :authorize_request, only: %i[index]

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
    @pizza.update(pizza_params)
    head :no_content
  end

  # /delete
  def destroy
    @pizza.destroy
    head :no_content
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
