class Api::V1::DashboardController < ApplicationController
  def index
    # uid = request.headers['uid'].to_i
    uid = 6
    dashboard_contents = {
      interviews: Interview.includes(:company).where(user_id: uid).where(status: false).where("date >= ?", Time.current).order(date: :asc).limit(3).as_json(methods: [:company_name]),
      meetings: Meeting.includes(:company).where(user_id: uid).where(status: false).where("date >= ?", Time.current).order(date: :asc).limit(3).as_json(methods: [:company_name]),
      submissions: Submission.includes(:company).where(user_id: uid).where(status: false).where("deadline >= ?", Time.current).order(deadline: :asc).limit(3).as_json(methods: [:company_name])
    }
    render json: dashboard_contents
  end
end