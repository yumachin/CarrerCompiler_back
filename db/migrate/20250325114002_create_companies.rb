class CreateCompanies < ActiveRecord::Migration[8.0]
  def change
    create_table :companies do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, default: "", null: false
      t.integer :industry, default: 0
      t.integer :employees, default: 0
      t.string :website, default: ""
      t.string :address, default: ""
      t.integer :income, default: 0
      t.integer :holidays, default: 0
      t.string :working_hours, default: ""
      t.string :other, default: ""
      t.boolean :favorite, default: false, null: false

      t.timestamps
    end
  end
end
