class CreateExchangeRates < ActiveRecord::Migration[7.2]
  def change
    create_table :exchange_rates do |t|
      t.date :date
      t.string :currency
      t.float :rate

      t.timestamps
    end
  end
end
