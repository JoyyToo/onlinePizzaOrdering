class FeedbacksController < ApplicationController
  before_action :verify_jwt_token
  before_action :account_activated
  before_action :set_user, only: [:create]
  before_action :ensure_admin!, except: %i[create]

  swagger_controller :feedbacks, 'Feedback'

  swagger_api :index do
    summary 'Get all feedback given by users'
    response :unauthorized
    response :bad_request
    response :not_found
  end

  swagger_api :create do
    summary 'Give feedback'
    param :path, :user_id, :required, :integer, 'User ID'
    param :form, :comment, :required, :integer, 'Comment'
    response :unauthorized
    response :bad_request
  end

  def index
    @feedbacks = Feedback.all
    json_response(@feedbacks)
  end

  def create
    @feedback = Feedback.where(user_id: @user.id).create(feedback_params)
    if @feedback.valid?
      json_response({ message: Message.feedback_submitted }, :created)
    else
      json_response(@feedback.errors.messages, :bad_request)
    end
  end

  private

  def feedback_params
    params.permit(:comment, :user_id)
  end
end
