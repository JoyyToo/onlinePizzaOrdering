class FeedbacksController < ApplicationController
  before_action :verify_jwt_token

  before_action :set_user, only: [:create]
  before_action :ensure_admin!, except: %i[create]

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

  def set_user
    token = AuthToken.decode(request.headers['Authorization'].split(' ').last)
    @user = User.find_by(id: token.first.values[0])
    if !@user
      json_response({ Message: Message.not_found }, :not_found)
    else
      @user
    end
  end
end
