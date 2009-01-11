class Mission < ActiveRecord::Base
  has_many :instances
    
  def pending
    0
  end
  
  def submitted
    0
  end
  
  def working
    0
  end
  
  def complete 
    0
  end
  
  def progress
    0
  end
  
end