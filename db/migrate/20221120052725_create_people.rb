class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :email
      t.date :dob, null: false
      t.string :street, null: false
      t.string :zip, null: false
      t.string :city, null: false
      t.string :country_code, null: false
      t.string :phone
      t.timestamps
    end
  end
end
