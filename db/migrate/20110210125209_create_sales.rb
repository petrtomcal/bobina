class CreateSales < ActiveRecord::Migration
  def self.up
    create_table :sales do |t|
      t.column :name, :string
      t.column :product_id, :integer
      t.column :pack_id, :integer
      t.column :paid, :integer
      t.column :user_id, :integer
      t.column :user_email, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :sales
  end
end
