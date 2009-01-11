class InstancesController < ApplicationController
  
  layout 'home'
  
  def new
    @instance = Instance.new
    @tasks = VehicleAssembly::Task.all
  end
  
  def create
    # @instance = Instance.new(params[:instance])
    @specification = Specification.new(:name => "Specification for #{@instance.name}")
      
    params[:specification][:tasks].each do |task|
      item = SpecificationItem.new( :name => task, :capistrano_task => task)
      @specification.specification_items << item
    end

    if @specification.save
      flash[:notice] = "Your instance has been staged, but not launched."
      redirect_to :controller => :missions, :action => :new
      return
    end
    
    flash[:notice] = "There was a problem in preparing your instance."
    redirect_to :action => :new
     
  end
  
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
