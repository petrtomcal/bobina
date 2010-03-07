class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.column :name, :string
      t.column :category_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
