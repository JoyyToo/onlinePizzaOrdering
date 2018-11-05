class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show destroy]
  before_action :verify_jwt_token, except: %i[all_pizzas index]
  before_action :ensure_admin!, except: %i[all_pizzas index show]

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
    @category = Category.create(category_params)
    if @category.valid?
      json_response(@category, :created)
    else
      json_response(@category.errors.messages, :bad_request)
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
end
