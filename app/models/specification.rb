class Specification < ActiveRecord::Base
  has_many :specification_items
  has_many :instances
end
