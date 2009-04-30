class Instance
  
  cattr_accessor :ec2
  attr_accessor :name, :id
  
  def initialize(prefix)
    self.name = prefix + ".compute-1.amazonaws.com"
    aws_details
  end
  
  def self.describe
    all_instances = ec2.describe_instances
    all_instances.select {|i| i[:aws_state] == "running" || "reserved"}.select {|i| i[:aws_instance_type] == "m1.large"}.sort_by {|i| i[:aws_availability_zone]}.reverse
  end
  
  def aws_details
    ec2.describe_instances.each do |instance|
      if instance[:dns_name] == self.name
        self.id = instance[:aws_instance_id]
      end
    end
  end
  
  def self.increase(count = 1)
    key = ec2.describe_key_pairs.first
    ec2.run_instances('ami-571efa3e', 1, 1, ['default'], 'gsg-keypair', '', nil, 'm1.large')
  end
  
  def ec2
    self.class.ec2
  end
    
end