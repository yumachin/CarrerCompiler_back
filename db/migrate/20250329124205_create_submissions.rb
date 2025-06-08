class CreateSubmissions < ActiveRecord::Migration[8.0]
  def change
    create_table :submissions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.datetime :deadline, null: true
      t.integer :submission_type, default: 0, null: false
      t.boolean :status, default: false, null: false
      t.string :contact_media, default: '', null: false
      t.string :submission_url, default: '', null: false

      t.timestamps
    end
  end
end
