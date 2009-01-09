class HomeController < ApplicationController
    
  before_filter :login_required, :except => :home
  layout 'home', :except => :home

  require 'capistrano/configuration'
  
  def home
  end
  
  def dashboard
    config = Capistrano::Configuration.new
    config.load "standard"
    config.load "deploy"
    config.load "config/deploy"
    config.task_list(:all).each do |task|
      logger.debug "TASK: #{task.name}"
    end
  end
  
  def index
    @instances = ec2.describe_instances
    @job_queue = sqs.queue("jobqueue")
    @pending = Job.pending
    @complete = Job.complete
    @submitted = Job.submitted    
    @working = Job.working
    @progress = Progress.so_far
    
    @capacity = @instances.size * 2
  end
  
  def status
    @instances = ec2.describe_instances
    @job_queue = sqs.queue("jobqueue")
    @pending = Job.pending
    @complete = Job.complete
    @submitted = Job.submitted    
    @working = Job.working
    @progress = Progress.so_far
    
    @capacity = @instances.size * 2
    render :partial => 'status', :locals => { :pending => @pending.size, :submitted => @submitted.size, :working => @working.size, :complete => @complete.size, :progress => @progress }
  end
    
end
