class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.decimal :price, precision: 8, scale: 2, default: 0.00
      t.decimal :discount, precision: 8, scale: 2, default: 0.00
      t.decimal :vat, precision: 8, scale: 2, default: 0.00
      t.string :image
      t.boolean :allow_discount, default: false
      t.boolean :freight, default: true

      t.timestamps
    end
    add_index :products, :slug
  end
end
