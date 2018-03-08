class AddColumnPriceToExcursions < ActiveRecord::Migration
  def change
    add_column :excursions, :price, :string, array: true
    add_column :excursions, :type_activity, :string, default: ''
  end
end
