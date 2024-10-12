class CreateShippingOptions < ActiveRecord::Migration[7.2]
  def change
    create_table :shipping_options do |t|
      t.string :origin_port
      t.string :destination_port
      t.date :departure_date
      t.date :arrival_date
      t.string :sailing_code

      t.timestamps
    end
  end
end
