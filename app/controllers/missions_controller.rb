class MissionsController < ApplicationController
  
  layout 'home'
  
  def new
    @mission = Mission.new
  end
  
end
