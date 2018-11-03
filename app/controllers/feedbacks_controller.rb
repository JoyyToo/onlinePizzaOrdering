class FeedbacksController < ApplicationController
  before_action :verify_jwt_token

  before_action :set_feedback
  before_action :set_user

  def index
    @feedbacks = Feedback.all
    json_response(@feedbacks)
  end

  def create
    @feedback = current_user.feedbacks.create!(feedback_params)
    response = { message: Message.feedback_submitted }
    json_response(response, :created)
  end

  private

  def feedback_params
    params.permit(:comment, :user_id)
  end

  def set_feedback
    @feedback = @user.feedbacks.find_by!(id: params[:id]) if @user
  end

  def set_user
    @user = User.find(id: params[:user_id])
  end
end
