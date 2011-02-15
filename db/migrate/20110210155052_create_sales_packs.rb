class CreateSalesPacks < ActiveRecord::Migration
  def self.up
    create_table :sales_packs do |t|
      t.column :sale_id, :integer
      t.column :pack_id, :integer
      t.column :count, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :sales_packs
  end
end
