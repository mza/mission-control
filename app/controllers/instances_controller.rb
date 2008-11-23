class InstancesController < ApplicationController
  
  layout 'jobs'
  
  def show
    @instance = Instance.new params[:id]
    @jobs = Job.find_all_by_node @instance.name
  end
  
  def destroy
    instance_id = params[:id]
    ec2.terminate_instances instance_id
    redirect_to :controller => :home
  end
  
end
