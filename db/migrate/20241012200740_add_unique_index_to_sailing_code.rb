class AddUniqueIndexToSailingCode < ActiveRecord::Migration[7.2]
  def change
    add_index :shipping_options, :sailing_code, unique: true
  end
end
