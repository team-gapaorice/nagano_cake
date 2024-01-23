class CreateDeliveryDestinations < ActiveRecord::Migration[6.1]
  def change
    create_table :delivery_destinations do |t|
      t.integer :customer_id, null: false
      t.string :name, null: false
      t.string :postal_code, null: false
      t.string :adress, null: false
      t.timestamps
    end
  end
end
