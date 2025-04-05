class Api::V1::CompaniesController < ApplicationController
  before_action :set_user

  def index
    uid = request.headers['uid'].to_i
    companies = Company.where(user_id: uid).order(id: :desc)
    render json: companies
  end

  def show
    company = Company.find(params[:id])
    company.user_id = request.headers['uid'].to_i
    render json: company
  end
  
  def create
    name = params[:company][:name] 
    if Company.exists?(name: name)
      company = Company.find_by(name: name)
      company.user_id = request.headers['uid'].to_i
      render json: company, status: :ok
      return
    end

    company = Company.new(company_params)
    company.user_id = request.headers['uid'].to_i

    if company.save
      render json: company, status: :created
    else
      render json: company.errors, status: :unprocessable_entity
    end
  end

  def update
    company = Company.find(params[:id])
    if company.update(company_params)
      render json: company, status: :ok
    else
      render json: company.errors, status: :unprocessable_entity
    end
  end

  private
  def company_params
    params.require(:company).permit(
    :name, :industry, :employees, :website, :address, :income,
    :holidays, :working_hours, :other, :favorite, :memo
    )
  end
end