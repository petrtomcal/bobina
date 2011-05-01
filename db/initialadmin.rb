#!ruby

require 'optparse'

OPTIONS = {
  :environment => "development",
}

ARGV.options do |opts|
  script_name = File.basename($0)
  opts.banner = "Usage: ruby #{script_name} [options]"

  opts.separator ""

  opts.on("-e", "--environment=name", String,
          "Specifies the environment to run this server under (test/development/production).",
          "Default: production") { |OPTIONS[:environment]| }

  opts.separator ""

  opts.on("-h", "--help",
          "Show this help message.") { puts opts; exit }

  opts.parse!
end

ENV["RAILS_ENV"] = OPTIONS[:environment]
require File.join(File.dirname(__FILE__), '/../config/environment')
require 'digest/sha2'
#######user
   admin = User.new(:email => 'test@admin.com', :password_hash =>'824b3e7b0db94d1ff31b350c54613a77faedd129099a7273a5f4505321b47a13', :admin => '1', :authorization => '1', :first_name => 'test', :last_name => 'test') 
   if admin.save(false)
    puts 'OK' 
   else
    puts 'CHYBA'
   end
   
   admin = User.new(:email => 'test@test.cz', :password_hash =>'824b3e7b0db94d1ff31b350c54613a77faedd129099a7273a5f4505321b47a13', :admin => '1', :authorization => '1', :first_name => 'testuser', :last_name => 'testuser') 
   if admin.save(false)
    puts 'OK' 
   else
    puts 'CHYBA'
   end
