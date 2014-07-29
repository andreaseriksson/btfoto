class AddPrintedAtToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :printed_at, :datetime
  end
end
