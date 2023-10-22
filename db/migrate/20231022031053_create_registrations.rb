class CreateRegistrations < ActiveRecord::Migration[7.0]
  def change
    create_table :registrations do |t|
      t.references :person, null: false, foreign_key: true
      t.references :camp, null: false, foreign_key: true
      t.date :arrival_date
      t.date :departure_date

      t.timestamps
    end
    add_index :registrations, [:person, :camp], unique: true
  end
end
