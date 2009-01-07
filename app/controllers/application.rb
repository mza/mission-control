# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

# require 'right_aws'

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'c4c55c2adcc7129fd790d57b2ac375b1'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
      
  def ec2
    AWS.ec2
  end
  
  def sqs
    AWS.sqs
  end
  
  def s3
    AWS.s3
  end
    
end
