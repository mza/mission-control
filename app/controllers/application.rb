# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

require 'right_aws'

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'c4c55c2adcc7129fd790d57b2ac375b1'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  settings = YAML.load(File.open("#{Rails.root}/config/aws.yml")).symbolize_keys
  EC2 = RightAws::Ec2.new(settings[:access_key_id], settings[:secret_access_key])
  SQS = RightAws::SqsGen2.new(settings[:access_key_id], settings[:secret_access_key])
  S3 = RightAws::S3.new(settings[:access_key_id], settings[:secret_access_key])
  
  Instance.ec2 = EC2
  
  def ec2
    EC2
  end
  
  def sqs
    SQS
  end
  
  def s3
    S3
  end
    
end
