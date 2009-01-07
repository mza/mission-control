class Amazon
  
  @@settings = nil
  
  private 
  
    def self.load_settings  
      if @@settings.nil?
        @@settings = YAML.load(File.open("#{Rails.root}/config/aws.yml")).symbolize_keys
      end
    end
  
    def self.settings
      @@settings
    end
  
  public
  
  def self.ec2
    load_settings
    RightAws::Ec2.new(settings[:access_key_id], settings[:secret_access_key])
  end
  
  def self.sqs
    load_settings
    RightAws::SqsGen2.new(settings[:access_key_id], settings[:secret_access_key])
  end
  
  def self.s3
    load_settings
    RightAws::S3.new(settings[:access_key_id], settings[:secret_access_key])
  end
  
end