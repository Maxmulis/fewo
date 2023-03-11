class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :number, null: false
      t.string :floor, null: false
      t.integer :capacity, null: false
      t.references :camp, null: false, foreign_key: true

      t.timestamps
    end
  end
end
