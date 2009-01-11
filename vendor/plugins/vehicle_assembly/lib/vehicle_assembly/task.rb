module VehicleAssembly
  class Task
    require 'capistrano/configuration'

    attr_accessor :cap_task
    
    def self.all
      tasks = []
      config = Capistrano::Configuration.new
      config.load "config/deploy"
      config.task_list(:all).each do |task|
        tasks << self.new(task)
      end
      tasks.sort_by {|t| t.name}
    end
    
    def initialize(task)
      @cap_task = task
    end
    
    def name
      cap_task.fully_qualified_name
    end
        
    def self.logger
      RAILS_DEFAULT_LOGGER
    end
    
  end
end