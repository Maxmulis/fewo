class CreateResponsibilities < ActiveRecord::Migration[7.0]
  def change
    create_table :responsibilities do |t|
      t.references :person, null: false, foreign_key: true
      t.references :registration, null: false, foreign_key: true

      t.timestamps
    end
  end
end
