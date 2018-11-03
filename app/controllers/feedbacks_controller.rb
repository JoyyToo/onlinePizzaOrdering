class FeedbacksController < ApplicationController

  def index
    @feedbacks = Feedback.all
    json_response(@feedbacks)
  end

  def create
    @feedback = current_user.feedbacks.create!(feedback_params)
    response = { message: Message.feedback_submitted }
    json_response(response, :created)
  end

  def feedback_params
    params.permit(:comment, :user_id)
  end

  def set_feedback
    @feedback = Feedback.find(params[:id])
  end
end
