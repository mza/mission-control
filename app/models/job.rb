class Job < ActiveRecord::Base

  def self.running_count_for_instance(name)
    Job.find_all_by_node_and_status(name, "working").size
  end
  
  def self.complete
    Job.find :all, :conditions => { :status => "complete" }
  end

  def self.pending
    Job.find :all, :conditions => { :status => "pending" }
  end

  def self.submitted
    Job.find :all, :conditions => { :status => "submitted" }
  end
  
  def self.working
    Job.find :all, :conditions => { :status => "working" }
  end
  
  def allocated_instance
    if self.node.blank?
      return "unallocated"
    end
    self.node    
  end
  
  def self.update(message)
    if message != ""
      # Complete: SRR002609.over60.fastq.04 : ec2-67-202-19-202.compute-1.amazonaws.com
      fields = message.to_s.split ":"
      if fields.size == 3
        status = fields[0]
        name = fields[1].strip
        node = fields[2].strip
        j = find_by_name name
        unless j.blank?
          if status == "Start"
            if j.status != "complete"
              j.node = node
              j.status = "working"
              j.save
            end
          elsif status == "Complete"
            j.status = "complete"
            j.save
          end
        end
        
      end
    end
  end
  
end
