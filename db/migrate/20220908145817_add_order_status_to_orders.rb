class AddOrderStatusToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :order_status, :integer, null: false, default: 0
  end
end
