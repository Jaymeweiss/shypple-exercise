class AddUniqueIndexToDateInExchangeRates < ActiveRecord::Migration[7.2]
  def change
    add_index :exchange_rates, [ :date, :currency ], unique: true
  end
end
