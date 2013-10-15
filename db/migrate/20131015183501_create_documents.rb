class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :file_name
      t.string :file_type
      t.string :file_size

      t.timestamps
    end
  end
end
