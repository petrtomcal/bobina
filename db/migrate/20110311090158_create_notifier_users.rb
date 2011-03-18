class CreateNotifierUsers < ActiveRecord::Migration
  def self.up
    create_table :notifier_users do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :notifier_users
  end
end
