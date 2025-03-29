class Submission < ApplicationRecord
  belongs_to :company

  def company_name
    company.name
  end
end
