class AddAttributToEshops < ActiveRecord::Migration
  def self.up
    add_column :eshops, :email, :string
    add_column :eshops, :password_hash, :string
  end

  def self.down
    remove_column :eshops, :email
    remove_column :eshops, :password_hash
  end
end
