class CreateCamps < ActiveRecord::Migration[7.0]
  def change
    create_table :camps do |t|
      t.string :place, null: false
      t.date :startdate, null: false
      t.date :enddate, null: false
      t.timestamps
    end
  end
end
