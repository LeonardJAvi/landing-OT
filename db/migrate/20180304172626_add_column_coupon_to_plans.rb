class AddColumnCouponToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :coupon, :integer, default: 0
  end
end
