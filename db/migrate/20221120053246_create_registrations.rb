class CreateRegistrations < ActiveRecord::Migration[7.0]
  def change
    create_table :registrations do |t|
      t.date :arrival_date
      t.date :departure_date
      t.references :camp, null: false, foreign_key: true
      t.references :room, foreign_key: true
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
