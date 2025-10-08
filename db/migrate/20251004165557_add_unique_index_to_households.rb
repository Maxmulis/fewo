class AddUniqueIndexToHouseholds < ActiveRecord::Migration[8.0]
  def change
    add_index :households, [:street, :number, :zip_code, :town, :country_code, :recipient],
              unique: true,
              name: 'index_households_on_address_and_recipient'
  end
end
