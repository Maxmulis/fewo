class CreateRoomAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :room_assignments do |t|
      t.references :person, null: false, foreign_key: true
      t.references :camp, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
