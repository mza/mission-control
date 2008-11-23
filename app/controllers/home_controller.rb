class HomeController < ApplicationController
    
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
