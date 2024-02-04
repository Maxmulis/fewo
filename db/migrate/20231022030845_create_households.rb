class CreateHouseholds < ActiveRecord::Migration[7.0]
  def change
    create_table :households do |t|
      t.string :street
      t.string :zip_code
      t.string :number
      t.string :country_code
      t.string :town
      
      t.timestamps
    end
  end
end
