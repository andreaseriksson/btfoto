class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :titel
      t.string :slug
      t.text :preamble
      t.text :content

      t.timestamps
    end
    add_index :news, :slug
  end
end
