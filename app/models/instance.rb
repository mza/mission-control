class Instance
  
  cattr_accessor :ec2
    
  def self.launch_with_specification(spec)
    ec2.run_instances('ami-1f5db976', 1, 1, ['default'], 'gsg-keypair')
  end
  
  def aws_details
    ec2.describe_instances.each do |instance|
      if instance[:dns_name] == self.name
        self.id = instance[:aws_instance_id]
      end
    end
  end
  
  def ec2
    Amazon.ec2
  end
  
  def self.ec2
    Amazon.ec2
  end
    
end