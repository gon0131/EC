class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :payment_amount
      t.integer :postage
      t.string :post_code
      t.string :address
      t.string :recipient_name

      t.timestamps
    end
  end
end
