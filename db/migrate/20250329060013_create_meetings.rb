class CreateMeetings < ActiveRecord::Migration[8.0]
  def change
    create_table :meetings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.datetime :date, null: true
      t.string :meeting_type, default: ""
      t.string :online_url, default: ""
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
