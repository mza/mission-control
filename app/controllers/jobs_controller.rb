class JobsController < ApplicationController
  
  def index
    @jobs = Job.all
    @pending_jobs = Job.pending
    @working_jobs = Job.working
  end
  
  def from_s3
    @buckets = s3.buckets
  end
  
  def bucket
    @objects = s3.bucket(params[:bucket][:name]).keys
  end
  
  def create
    params[:objects].each do |object, checked|
      if checked == "1"
        job = Job.create(:name => object, :status => "pending")
      end
    end
    
    redirect_to :action => :index
  end
  
  def submit
    params[:objects].each do |object, checked|
      if checked == "1"
        j = Job.find_by_name object
        j.status = "submitted"
        if j.save
          jobs = sqs.queue('jobqueue')
          jobs.send_message(object)
        end
      end
    end
    redirect_to :controller => :home, :action => :index
  end

  def unplug    
    ec2.describe_instances.each do |instance|
      ec2.terminate_instances instance[:aws_instance_id]
    end
    redirect_to :controller => :home, :action => :index
  end
    
end
