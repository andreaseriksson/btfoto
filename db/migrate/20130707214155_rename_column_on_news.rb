class RenameColumnOnNews < ActiveRecord::Migration
  def change
    rename_column :news, :titel, :title
  end
end
