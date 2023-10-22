class CreateCamps < ActiveRecord::Migration[7.0]
  def change
    create_table :camps do |t|
      t.date :start_date
      t.date :end_date
      t.references :place, null: false, foreign_key: true

      t.timestamps
    end
  end
end
