class AddUserIdToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :user, foreign_key: true, null: false, index: true
  end
end
