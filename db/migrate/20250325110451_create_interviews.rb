class CreateInterviews < ActiveRecord::Migration[8.0]
  def change
    create_table :interviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.datetime :date, null: true
      t.integer :selection_id, default: 0
      t.string :interview_type, default: ""
      t.string :online_url, default: ""
      t.boolean :status, default: false

      t.timestamps
    end
  end
end