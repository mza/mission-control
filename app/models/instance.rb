class Instance < ActiveRecord::Base
  
  belongs_to :mission
  has_one :specification
  
  cattr_accessor :ec2
  attr_accessor :name, :id
  
  def initialize(prefix)
    self.name = prefix + ".compute-1.amazonaws.com"
    aws_details
  end
  
  def aws_details
    ec2.describe_instances.each do |instance|
      if instance[:dns_name] == self.name
        self.id = instance[:aws_instance_id]
      end
    end
  end
  
  def ec2
    self.class.ec2
  end
    
end