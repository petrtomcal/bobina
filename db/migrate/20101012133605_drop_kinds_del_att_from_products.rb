class DropKindsDelAttFromProducts < ActiveRecord::Migration
  def self.up
    remove_column :products, :attachment_file_name
    remove_column :products, :attachment_content_type 
    remove_column :products, :attachment_file_size  
  end

  def self.down
  end
end
