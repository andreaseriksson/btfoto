class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :first_name
      t.string :family_name
      t.string :address1
      t.string :address2
      t.string :phone
      t.string :email
      t.string :city
      t.string :zip
      t.decimal :shipping_cost, precision: 8, scale: 2, default: 0.00
      t.boolean :confirmed
      t.string :token
      t.string :payment_type
      t.boolean :extra_shipment

      t.timestamps
    end
  end
end
