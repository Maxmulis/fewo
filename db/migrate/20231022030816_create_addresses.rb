class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :zip_code
      t.string :number
      t.string :country_code
      t.string :town

      t.timestamps
    end
    add_index :addresses, [:street, :zip_code, :number, :country_code, :town], unique: true, name: 'index_addresses_on_all_fields'
  end
end
