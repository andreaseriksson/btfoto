class AddPublishedAtToNews < ActiveRecord::Migration
  def change
    add_column :news, :published_at, :date
  end
end
