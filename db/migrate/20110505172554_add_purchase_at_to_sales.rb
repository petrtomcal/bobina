class AddPurchaseAtToSales < ActiveRecord::Migration
  def self.up
    add_column :sales, :purchased_at, :datetime
  end

  def self.down
    remove_column :sales, :purchased_at
  end
end
