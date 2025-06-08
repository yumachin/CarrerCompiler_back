class AddNotNullConstraintsToInterviews < ActiveRecord::Migration[8.0]
  def change
    change_column_null :interviews, :selection_id, false
    change_column_null :interviews, :interview_type, false
    change_column_null :interviews, :online_url, false
    change_column_null :interviews, :status, false
  end
end
