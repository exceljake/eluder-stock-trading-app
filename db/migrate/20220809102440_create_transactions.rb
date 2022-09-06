class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :stock_id
      t.string :action
      t.decimal :quantity
      t.decimal :price
      t.decimal :total_amount
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
