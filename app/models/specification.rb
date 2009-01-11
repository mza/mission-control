class Specification < ActiveRecord::Base
  has_many :specification_items
  has_many :instances
  
  def snippet
    specification_items.join ", "
  end
  
  
end
