class CreateExchangeRates < ActiveRecord::Migration[7.2]
  def change
    create_table :exchange_rates do |t|
      t.date :date
      t.float :usd
      t.float :jpy

      t.timestamps
    end
  end
end
