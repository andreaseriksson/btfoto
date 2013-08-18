class CreateProductCategories < ActiveRecord::Migration
  def change
    create_table :product_categories do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
    add_index :product_categories, :slug
  end
end
