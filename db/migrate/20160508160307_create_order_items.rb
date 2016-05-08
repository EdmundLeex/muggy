class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :order,  foreign_key: true, null: false, index: true
      t.integer :quantity, null: false

      t.timestamps null: false
    end
  end
end
