class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :banner
      t.string :title
      t.text :subtitle
      t.string :days
      t.string :url
      t.string :destination_id
      t.string :slug

      t.integer :position
      t.timestamps null: false
    end
    add_index :plans, :slug, unique: true
  end
end
