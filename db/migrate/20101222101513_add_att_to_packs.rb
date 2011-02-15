class AddAttToPacks < ActiveRecord::Migration
  def self.up
    add_column :packs, :description, :string
    add_column :packs, :price, :decimal, :precision => 8, :scale => 2, :default => 0
  end

  def self.down
    remove_column :packs, :description
    remove_column :packs, :price
  end
end