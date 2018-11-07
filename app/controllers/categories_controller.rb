class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show destroy update]
  before_action :verify_jwt_token, except: %i[all_pizzas index]
  before_action :ensure_admin!, except: %i[all_pizzas index show]

  def index
    @categories = Category.all
    json_response(@categories)
  end

  # /home
  def all_pizzas
    unless params[:per_page]
      params[:per_page] = 10
    end

    unless params[:page]
      params[:page] = 1
    end

    @pizzas = Pizza.all.paginate(
      page: params[:page], per_page: params[:per_page]
    )
    json_response(meta: {
                    page: params[:page].to_f,
                    limit: params[:per_page].to_f,
                    total_pages: (@pizzas.count.to_f / params[:per_page].to_f).ceil
                  },
                  data: @pizzas)
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
end
