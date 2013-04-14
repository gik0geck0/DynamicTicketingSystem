class Statuses < ActiveRecord::Base
  validates_uniqueness_of :name
  attr_accessible :id, :name
end
