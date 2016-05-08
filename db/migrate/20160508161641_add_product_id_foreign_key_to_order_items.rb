class AddProductIdForeignKeyToOrderItems < ActiveRecord::Migration
  def change
    add_reference :order_items, :product, foreign_key: true, index: true, null: false
  end
end
