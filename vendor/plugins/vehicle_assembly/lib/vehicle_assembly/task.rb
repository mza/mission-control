module VehicleAssembly
  class Task
    require 'capistrano/configuration'

    attr_accessor :cap_task
    
    def self.all
      tasks = []
      config = Capistrano::Configuration.new
      config.load "standard"
      config.load "deploy"
      config.load "config/deploy"
      config.task_list(:all).each do |task|
        tasks << self.new(task)
      end
      tasks
    end
    
    def initialize(task)
      @cap_task = task
    end
    
    def self.logger
      RAILS_DEFAULT_LOGGER
    end
    
  end
end