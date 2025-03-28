class Api::V1::CompaniesController < ApplicationController
  before_action :set_user
  
  def create
    company = Company.new(company_params)
    if company.save
      render json: company, status: :created
    else
      render json: company.errors, status: :unprocessable_entity
    end
  end

  private
  def company_params
    params.require(:company).permit(
    :user_id, :name, :industry, :employees, :website, :address, 
    :income, :holidays, :working_hours, :other, :favorite
    )
  end
end