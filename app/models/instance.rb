class Instance
  
  cattr_accessor :ec2
    
  def self.launch_with_specification(spec)
    ubuntu = "ami-1f5db976"
    ssaha = "ami-571efa3e"
    ec2.run_instances(ssaha, 1, 40, ['default'], 'gsg-keypair', '', nil, 'm1.large')
    # image_id, min_count, max_count, group_ids, key_name, user_data='',  
    #                       addressing_type = nil, instance_type = nil,
    #                       kernel_id = nil, ramdisk_id = nil, availability_zone = nil, 
    #                       block_device_mappings = nil)
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