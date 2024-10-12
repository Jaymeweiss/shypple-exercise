class CreateRates < ActiveRecord::Migration[7.2]
  def change
    create_table :rates do |t|
      t.string :sailing_code
      t.float :rate
      t.string :rate_currency

      t.timestamps
    end
  end
end
