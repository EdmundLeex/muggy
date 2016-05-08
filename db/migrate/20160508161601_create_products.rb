class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, null: false, index: true
      t.integer :price, null: false
      t.text :description
      t.text :remark

      t.timestamps null: false
    end
  end
end
