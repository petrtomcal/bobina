require 'ruby-debug'

dbs = ['buk_eshop','vitana_eshop','bobina']
namespace :db do
  desc "Migrate specific database. Database name must be specified in DB=x also in VERSION=x you can specify version." 
  task :migrate_db => :environment do 
    puts "Migrating: " + ENV["DB"].to_s 
    ActiveRecord::Base.remove_connection() 
    conn = ActiveRecord::Base.configurations['development'] 
    conn.merge!({'database' => ENV["DB"]}) 
    ActiveRecord::Base.establish_connection(conn)  
    ActiveRecord::Migrator.migrate("db/migrate/", ENV["VERSION"] ? ENV["VERSION"].to_i : nil) 
    puts "Done." 
    ActiveRecord::Base.remove_connection() 
  end
  
  desc "Migrate specifyg DB from any array"
  task :migrate_all_db => :environment do
    eshops = AdminEshop.find(:all)
    eshops.each do |eshop|
      db = "#{eshop.domain}_eshop"
      version = "VERSION=#{ENV["VERSION"]}" if ENV["VERSION"]
      puts "rake db:migrate_db DB=#{db} #{version}"
      system "rake db:migrate_db DB=#{db}"
    end
  end  
end
