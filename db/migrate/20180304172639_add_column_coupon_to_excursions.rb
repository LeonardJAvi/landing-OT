class AddColumnCouponToExcursions < ActiveRecord::Migration
  def change
    add_column :excursions, :coupon, :integer, default: 0
  end
end
