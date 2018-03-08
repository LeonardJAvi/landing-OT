class AddColumnPriceToHotels < ActiveRecord::Migration
  def change
    add_column :hotels, :price, :string, array: true
    # add_column :hotels, :price_usd, :float, default: ''
  end
end
