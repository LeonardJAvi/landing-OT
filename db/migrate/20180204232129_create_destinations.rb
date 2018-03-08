class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.string :name
      t.text :subtitle
      t.string :banner
      t.string :slug

      t.integer :position
      t.timestamps null: false
    end
    add_index :destinations, :slug, unique: true
  end
end
