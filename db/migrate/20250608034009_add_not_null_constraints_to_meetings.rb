class AddNotNullConstraintsToMeetings < ActiveRecord::Migration[8.0]
  def change
    change_column_null :meetings, :meeting_type, false
    change_column_null :meetings, :online_url, false
    change_column_null :meetings, :status, false
  end
end
