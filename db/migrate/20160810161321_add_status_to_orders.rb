class AddStatusToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :status, :integer, null: false, default: 0
    add_index :orders, :status
  end
end
