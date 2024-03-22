class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.string :name
      t.string :first_name
      t.string :phone
      t.date :dob
      t.references :household, foreign_key: true

      t.timestamps
    end
    add_index :people, [ :name, :first_name, :dob ], unique: true
  end
end
