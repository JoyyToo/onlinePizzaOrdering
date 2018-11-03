class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show destroy]
  before_action :verify_jwt_token, except: %i[all_pizzas index]

  def index
    @categories = Category.all
    json_response(@categories)
  end

  # /home
  def all_pizzas
    @pizzas = Pizza.all
    json_response(@pizzas)
  end

  def show
    json_response(@category)
  end

  def create
    @category = Category.create!(category_params)
    json_response(@category, :created)
  end

  def destroy
    @category.destroy
    head :no_content
  end

  private

  def category_params
    params.permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
