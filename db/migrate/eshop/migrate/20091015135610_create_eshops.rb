class CreateEshops < ActiveRecord::Migration
  def self.up
    create_table :eshops do |t|
      t.string :name, :domain
      t.timestamps
    end
  end

  def self.down
    drop_table :eshops
  end
end
