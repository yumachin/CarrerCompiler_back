class AddNotNullConstraintsToCompanies < ActiveRecord::Migration[8.0]
  def change
    change_column_null :companies, :industry, false
    change_column_null :companies, :employees, false
    change_column_null :companies, :website, false
    change_column_null :companies, :address, false
    change_column_null :companies, :income, false
    change_column_null :companies, :holidays, false
    change_column_null :companies, :working_hours, false
    change_column_null :companies, :other, false
    change_column_null :companies, :memo, false
  end
end
