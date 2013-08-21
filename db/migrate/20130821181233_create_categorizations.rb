class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations do |t|
      t.integer :product_id
      t.integer :product_category_id

      t.timestamps
    end
    add_index :categorizations, :product_id
    add_index :categorizations, :product_category_id
  end
end
