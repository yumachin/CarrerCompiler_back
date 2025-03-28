class Api::V1::InterviewsController < ApplicationController
  before_action :set_user
  
  def index
    interviews = Interview.all
    render json: interviews
  end

  def create
    interview = Interview.new(interview_params)
    if interview.save
      render json: interview, status: :created
    else
      render json: interview.errors, status: :unprocessable_entity
    end
  end

  private
  def interview_params
    params.require(:interview).permit(:user_id, :company_id, :date, :selection_id, :interview_type, :status, :online_url)
  end
end
