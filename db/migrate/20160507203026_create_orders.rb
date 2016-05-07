class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :order_number, null: false
      t.string :street_address, null: false
      t.string :street_address_2
      t.string :city, null: false
      t.string :state, null: false
      t.string :zipcode, null: false
      t.string :country, null: false
      t.string :phone_number, null: false

      t.timestamps null: false
    end

    add_index :orders, :order_number, unique: true
  end
end
