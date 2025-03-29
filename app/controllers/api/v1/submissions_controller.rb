class Api::V1::SubmissionsController < ApplicationController
  before_action :set_user
  
  def index
    uid = request.headers['uid'].to_i
    submissions = Submission.includes(:company).where(user_id: uid).order(status: :asc, id: :desc)
    render json: submissions.as_json(methods: [:company_name])
  end

  def create
    submission = Submission.new(submission_params)
    submission.user_id = request.headers['uid'].to_i

    if submission.save
      render json: submission, status: :created
    else
      render json: submission.errors, status: :unprocessable_entity
    end
  end

  def update
    submission = Submission.find(params[:id])
    if submission.update(submission_params)
      render json: submission, status: :ok
    else
      render json: submission.errors, status: :unprocessable_entity
    end
  end

  private
  def submission_params
    params.require(:submission).permit(:company_id, :deadline, :status, :submission_url, :contact_media, :submission_type)
  end
end
