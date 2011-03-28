class AddTokenToSale < ActiveRecord::Migration
  def self.up
    add_column :sales, :token, :string
    remove_column :sales, :user_email
  end

  def self.down
    remove_column :sales, :token
    add_column :sales, :user_email, :string
  end
end