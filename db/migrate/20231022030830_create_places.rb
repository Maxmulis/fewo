class CreatePlaces < ActiveRecord::Migration[7.0]
  def change
    create_table :places do |t|
      t.string :name

      t.timestamps
    end
    add_index :places, :name, unique: true
  end
end
