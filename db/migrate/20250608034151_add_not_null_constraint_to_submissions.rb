class AddNotNullConstraintToSubmissions < ActiveRecord::Migration[8.0]
  def change
    change_column_null :submissions, :submission_type, false
    change_column_null :submissions, :status, false
    change_column_null :submissions, :contact_media, false
    change_column_null :submissions, :submission_url, false
  end
end
