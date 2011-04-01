class AddDescriptionToProductPack < ActiveRecord::Migration
  def self.up
    add_column :products, :description, :string     
  end

  def self.down
    remove_column :products, :description    
  end
end
