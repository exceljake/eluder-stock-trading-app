class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.string :name
      t.decimal :latest_price
      t.string :change_percent
      t.string :exchange
      t.string :sector
      t.string :industry
      t.text :description
      t.string :logo

      t.timestamps
    end
  end
end
