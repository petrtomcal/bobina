class AddAttrToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :attachment_file_name, :string
    add_column :products, :attachment_content_type, :string
    add_column :products, :attachment_file_size, :integer
  end
 
  def self.down
    remove_column :products, :attachment_file_name
    remove_column :products, :attachment_content_type
    remove_column :products, :attachment_file_size
  end

end
