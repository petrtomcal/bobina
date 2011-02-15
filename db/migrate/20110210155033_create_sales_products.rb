class CreateSalesProducts < ActiveRecord::Migration
  def self.up
    create_table :sales_products do |t|
      t.column :sale_id, :integer
      t.column :product_id, :integer
      t.column :count, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :sales_products
  end
end
