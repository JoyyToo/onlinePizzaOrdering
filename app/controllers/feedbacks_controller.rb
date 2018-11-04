class FeedbacksController < ApplicationController
  before_action :verify_jwt_token

  before_action :set_user, only: [:create]
  before_action :ensure_admin!, except: %i[create]

  def index
    @feedbacks = Feedback.all
    json_response(@feedbacks)
  end

  def create
    @feedback = Feedback.create!(feedback_params)
    response = { message: Message.feedback_submitted }
    json_response(response, :created)
  end

  private

  def feedback_params
    params.permit(:comment, :user_id)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
