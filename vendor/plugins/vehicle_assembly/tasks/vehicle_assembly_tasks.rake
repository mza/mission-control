require "#{File.dirname(__FILE__)}/../lib/vehicle_assembly"

namespace :mission_control do
  
  desc "Place a new project under launch control"  
  task :init do
    VehicleAssembly::Parser.check
  end

end