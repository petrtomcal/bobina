class AddCategoryToPack < ActiveRecord::Migration
  def self.up
     add_column :packs, :category_id, :integer     
  end

  def self.down
    remove_column :packs, :category_id
  end
end
