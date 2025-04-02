class Api::V1::CountsController < ApplicationController
  # before_action :set_user

  def index
    # uid = request.headers['uid'].to_i
    uid = 6
    table_counts = {
      company_count: Company.where(user_id: uid).count,
      interview_count: Interview.where(user_id: uid).count,
      meeting_count: Meeting.where(user_id: uid).count,
      submission_count: Submission.where(user_id: uid).count
    }
  
    render json: table_counts
  end
end