class InstancesController < ApplicationController
  
  layout 'jobs'
  
  def show
    Instance.ec2 = ec2
    @instance = Instance.new params[:id]
    @jobs = Job.find_all_by_node @instance.name
  end
  
  def destroy
    instance_id = params[:id]
    ec2.terminate_instances instance_id
    redirect_to :controller => :home
  end
  
  def increase
  end
  
  def go
    count = params[:instance][:number]
    flash[:notice] = "#{count} new instances reserved"
    Instance.increase count
    redirect_to root_url
  end
  
end
