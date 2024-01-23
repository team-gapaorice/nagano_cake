class CreateOders < ActiveRecord::Migration[6.1]
  def change
    create_table :oders do |t|
      t.integer :customer_id, null: false
      t.integer :payment_method, null: false
      t.integer :billing_amount, null: false
      t.string :name, null: false
      t.string :postal_code, null: false
      t.string :adress, null: false
      t.integer :postage, null: false
      t.integer :status, null: false
      t.timestamps
    end
  end
end
