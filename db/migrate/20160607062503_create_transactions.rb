class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :processor, null: false
      t.string :processor_id, index: true
      t.string :status, null: false
      t.string :transaction_type, null: false
      t.integer :amount
      t.string :reason

      t.timestamps null: false
    end

    add_reference :transactions, :user, foreign_key: true, index: true, null: false
    add_reference :transactions, :order, foreign_key: true, index: true, null: false
  end
end
