class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :ancestry
      t.string :slug
      t.integer :position
      t.string :title
      t.text :content
      t.string :menu_title
      t.string :meta_title
      t.string :meta_keywords
      t.text :meta_description
      t.boolean :active, default: true
      t.string :url
      t.boolean :page_redirect, default: false
      t.date :start_date, default: '2013-06-23'
      t.date :end_date, default: '2016-06-23'

      t.timestamps
    end
    add_index :pages, :ancestry
    add_index :pages, :slug
  end
end
