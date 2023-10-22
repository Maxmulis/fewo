class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.references :place, null: false, foreign_key: true
      t.integer :floor
      t.integer :capacity
      t.integer :number

      t.timestamps
    end
  end
end
