class AddColumnPriceToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :price, :string, array: true
    # add_column :plans, :price_usd, :float, default: ''
  end
end
