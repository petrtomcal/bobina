class Kinds < ActiveRecord::Migration
  def self.up
    create_table :kinds do |t|
	    t.column :kind, :string
      t.column :lock_version, :integer, :default => 0      
      t.timestamps
    end
  end

  def self.down
    drop_table :kinds
  end
end
