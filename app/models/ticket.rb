class Ticket < ActiveRecord::Base
  has_one :user
  has_one :status

  validates_presence_of :status_id, :name, :user_id
  attr_accessible :description, :name, :status_id, :user_id
end
