class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.column :product_id, :integer
      t.column :file_file_name, :string
      t.column :file_content_type, :string
      t.column :file_file_size, :integer      
      t.timestamps
    end
  end

  def self.down
    drop_table :attachments
  end
end
