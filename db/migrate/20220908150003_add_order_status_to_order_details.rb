class AddOrderStatusToOrderDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :order_details, :order_status, :integer, null: false, default: 0
  end
end
