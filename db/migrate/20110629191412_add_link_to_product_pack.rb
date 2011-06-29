class AddLinkToProductPack < ActiveRecord::Migration
  def self.up
    add_column :products, :weblink, :text     
    add_column :packs, :weblink, :text
  end

  def self.down
    remove_column :products, :weblink
    remove_column :packs, :weblink
  end
end
