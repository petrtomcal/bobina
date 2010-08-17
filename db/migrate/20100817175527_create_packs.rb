class CreatePacks < ActiveRecord::Migration
  def self.up
    create_table :packs do |t|
      t.column :name, :string      
      t.timestamps
    end
  end

  def self.down
    drop_table :packs
  end
end
