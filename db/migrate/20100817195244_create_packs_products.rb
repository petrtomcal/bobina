class CreatePacksProducts < ActiveRecord::Migration
  def self.up
    create_table :packs_products do |t|
      t.column :pack_id, :integer
      t.column :product_id, :integer
      t.column :created_on, :datetime
      t.timestamps
    end
  end

  def self.down
    drop_table :packs_products
  end
end
