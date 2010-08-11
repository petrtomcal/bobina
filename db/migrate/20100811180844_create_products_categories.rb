class CreateProductsCategories < ActiveRecord::Migration
  def self.up
    create_table :products_categories do |t|
      t.column :product_id, :integer
      t.column :category_id, :integer
      t.column :created_on, :datetime
      t.timestamps
    end
  end

  def self.down
    drop_table :products_categories
  end
end
