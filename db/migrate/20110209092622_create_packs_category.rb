class CreatePacksCategory < ActiveRecord::Migration
  def self.up
    create_table :packs_categories do |t|
      t.column :pack_id, :integer
      t.column :category_id, :integer
      t.column :created_on, :datetime
      t.timestamps
    end
  end

  def self.down
    drop_table :packs_categories
  end
end
