class AddAmountToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :amount, :integer, null: false
  end
end
