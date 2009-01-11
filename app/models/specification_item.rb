class SpecificationItem < ActiveRecord::Base
  belongs_to :specification
  
  def to_s
    self.name
  end
end
