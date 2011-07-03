class CreatePaypalSetting < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.text :email, :secret, :cert_id, :url
      t.integer :user_id      
      t.timestamps
    end
  end

  def self.down
    drop_table :settings
  end
end