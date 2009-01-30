class Mission < ActiveRecord::Base
  has_many :instances
    
  def pending
    Job.pending.size
  end
  
  def submitted
    Job.submitted.size
  end
  
  def working
    Job.working.size
  end
  
  def complete 
    Job.complete.size
  end
  
  def progress
    Progress.so_far    
  end
  
end