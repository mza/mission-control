class MissionsController < ApplicationController
  
  layout 'home'
  
  def show
    @mission = Mission.find(params[:id])
    @instances = ec2.describe_instances
  end
  
  def status
    @mission = Mission.find(params[:id])
    @instances = ec2.describe_instances
    render :partial => "status"
  end
  
  def start
    @mission = Mission.find(params[:id])
    @specifications = Specification.all
  end
  
  def launch
    @mission = Mission.find(params[:id])
    params[:count].each do |id, number|
      specification = Specification.find(id)
      Instance.launch_with_specification specification
      flash[:notice] = "Instance launched."
    end
    redirect_to mission_url(@mission)
  end
  
  def new
    @mission = Mission.new
    @specifications = Specification.all
    @buckets = s3.buckets    
  end
  
  def create
    @mission = Mission.new(params[:mission])
    if @mission.save
      flash[:notice] = "Your mission has been launched. Godspeed, John Glenn. "
      redirect_to houston_url
      return
    else
      flash[:notice] = "Houston we have a problem: mission not started."
      render :action => :new
    end    
  end
  
end
