require 'optparse'

OPTIONS = {
  :environment => "admin_eshop",
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
  subdomain = AdminEshop.new(:name => 'diplomka', :domain =>'diplomka')
   
   if subdomain.save(false)
    puts 'OK' 
   else
    puts 'ERROR'
   end