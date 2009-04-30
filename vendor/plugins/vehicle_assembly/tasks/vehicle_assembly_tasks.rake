prefix = "#{File.dirname(__FILE__)}/../"

require "#{prefix}/lib/vehicle_assembly"

namespace :mission_control do
  
  desc "Place a new project under launch control"  
  task :init do    
    VehicleAssembly::Parser.prepare "#{prefix}/lib/deploy/templates/aws.erb", :for => "#{RAILS_ROOT}/config/aws.yml"    
    VehicleAssembly::Parser.prepare "#{prefix}/lib/deploy/templates/deploy.erb", :for => "#{RAILS_ROOT}/config/deploy.rb"    
    VehicleAssembly::Parser.prepare "#{prefix}/lib/deploy/templates/capfile.erb", :for => "#{RAILS_ROOT}/Capfile"        
  end
  
end