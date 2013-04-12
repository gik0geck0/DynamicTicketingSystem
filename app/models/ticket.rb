class Ticket < ActiveRecord::Base
  has_one :user
  has_one :status
  attr_accessible :description, :name, :status_id
end
