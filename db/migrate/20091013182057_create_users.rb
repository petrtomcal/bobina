class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
	    t.column :email, :string
      t.column :first_name, :string
      t.column :last_name, :string
      t.column :street, :string
      t.column :city, :string
      t.column :zip, :string
      t.column :state, :string 
      t.column :phone, :string
      t.column :last_login, :datetime      
      t.column :password_hash, :string
      t.column :lock_version, :integer, :default => 0      
      t.column :authorization, :integer
      t.column :admin, :integer 
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end