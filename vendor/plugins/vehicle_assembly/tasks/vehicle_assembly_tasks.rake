prefix = "#{File.dirname(__FILE__)}/../"

require "#{prefix}/lib/vehicle_assembly"

namespace :mission_control do
  
  desc "Place a new project under launch control"  
  task :init do
    file = "#{RAILS_ROOT}/config/aws.yml"
    unless File.exists? file
      File.open(file, 'w') do |f|
        f.write VehicleAssembly::Parser.parse("#{prefix}/lib/deploy/templates/aws.erb")
      end
    else
      puts "File '#{file}' exists and will not be overwritten."
    end
  end

end