class Api::V1::MeetingsController < ApplicationController
  before_action :set_user
  
  def index
    uid = request.headers['uid'].to_i
    meetings = Meeting.includes(:company).where(user_id: uid).order(status: :asc)
    render json: meetings.as_json(methods: [:company_name])
  end

  def create
    meeting = Meeting.new(meeting_params)
    meeting.user_id = request.headers['uid'].to_i

    if meeting.save
      render json: meeting, status: :created
    else
      render json: meeting.errors, status: :unprocessable_entity
    end
  end

  def update
    meeting = Meeting.find(params[:id])
    if meeting.update(meeting_params)
      render json: meeting, status: :ok
    else
      render json: meeting.errors, status: :unprocessable_entity
    end
  end

  private
  def meeting_params
    params.require(:meeting).permit(:company_id, :date, :meeting_type, :status, :online_url)
  end
end
