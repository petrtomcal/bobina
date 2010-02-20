class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.column :lock_version, :integer, :default => 0      
      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
