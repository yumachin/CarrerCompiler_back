class CreateCompanies < ActiveRecord::Migration[8.0]
  def change
    create_table :companies do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, default: "", null: false
      t.integer :industry, default: 0, null: false
      t.integer :employees, default: 0, null: false
      t.string :website, default: "", null: false
      t.string :address, default: "", null: false
      t.integer :income, default: 0, null: false
      t.integer :holidays, default: 0, null: false
      t.string :working_hours, default: "", null: false
      t.string :other, default: "", null: false
      t.boolean :favorite, default: false, null: false
      t.text :memo, default: "", null: false

      t.timestamps
    end
  end
end
