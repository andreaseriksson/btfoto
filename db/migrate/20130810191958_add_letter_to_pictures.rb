class AddLetterToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :letter, :string
    add_index :pictures, [:name, :letter]
  end
end
