class AddRecipientToHousehold < ActiveRecord::Migration[7.1]
  def change
    add_column :households, :recipient, :string
  end
end
