class AddSubdomainToAttachment < ActiveRecord::Migration
  def self.up
    add_column :attachments, :subdomain, :string
  end

  def self.down
    remove_column :attachments, :subdomain    
  end
end