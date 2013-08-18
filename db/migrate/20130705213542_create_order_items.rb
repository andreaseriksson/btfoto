class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.belongs_to :order, index: true
      t.belongs_to :product, index: true
      t.integer :quantity
      t.decimal :price, precision: 8, scale: 2, default: 0.00
      t.decimal :vat, precision: 8, scale: 2, default: 0.00
      t.decimal :discount, precision: 8, scale: 2, default: 0.00
      t.string :image_nr

      t.timestamps
    end
  end
end
