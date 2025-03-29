class Api::V1::InterviewsController < ApplicationController
  before_action :set_user
  
  def index
    uid = request.headers['uid'].to_i
    interviews = Interview.includes(:company).where(user_id: uid).order(status: :asc)
    render json: interviews.as_json(methods: [:company_name])
  end

  def create
    interview = Interview.new(interview_params)
    interview.user_id = request.headers['uid'].to_i

    if interview.save
      render json: interview, status: :created
    else
      render json: interview.errors, status: :unprocessable_entity
    end
  end

  def update
    interview = Interview.find(params[:id])
    if interview.update(interview_params)
      render json: interview, status: :ok
    else
      render json: interview.errors, status: :unprocessable_entity
    end
  end

  private
  def interview_params
    params.require(:interview).permit(:company_id, :date, :selection_id, :interview_type, :status, :online_url)
  end
end
