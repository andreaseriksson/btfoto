class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :username
      t.string :password
      t.string :first_name
      t.string :family_name
      t.string :address
      t.string :zip
      t.string :city
      t.string :country
      t.string :phone
      t.string :cellphone
      t.boolean :active, default: true

      t.timestamps
    end
    add_index :customers, :username
  end
end
