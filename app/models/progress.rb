class Progress < ActiveRecord::Base
  
  def self.so_far
    value = 0
    Progress.all.each do |p|
      unless p.value.blank?
        value = value + p.value
      end
    end
    value
  end
  
  def self.update(message)
    # Update: Thu Nov 13 14:18:57 UTC 2008
    # 10434
    #  : ec2-67-202-19-202.compute-1.amazonaws.com
    if message != ""
      line = message.to_s.split "\n"
      unless line[1].blank?
        value = line[1].strip
        node = line[2].sub(":", "").strip
        unless node.blank?
          p = Progress.find_by_node node
          if p.nil?
            p = Progress.create :node => node
          end
          p.value = value.to_i
          p.save
        end
      end
    end
  end
  
end
