class AddColumnCouponToHotels < ActiveRecord::Migration
  def change
    add_column :hotels, :coupon, :integer, default: 0
  end
end
