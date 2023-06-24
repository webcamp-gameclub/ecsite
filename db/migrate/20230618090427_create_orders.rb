class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.string :name
      t.string :address1
      t.string :postal_code
      t.integer :postage
      t.integer :billing_amount
      t.integer :payment_method
      t.integer :order_status, default:0

      t.timestamps
    end
  end
end
