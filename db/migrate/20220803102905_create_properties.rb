class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.integer :stock_id
      t.decimal :quantity, default: 0.00
      t.references :portfolio, null: false, foreign_key: true

      t.timestamps
    end
  end
end
