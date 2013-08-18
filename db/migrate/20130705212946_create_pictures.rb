class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :year
      t.string :school
      t.string :no
      t.integer :rand
      t.string :name
      t.string :folder
      t.boolean :shown
      t.belongs_to :product_category, index: true

      t.timestamps
    end
  end
end
