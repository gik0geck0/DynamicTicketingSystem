class Ticket < ActiveRecord::Base
  # I feel like has_one should make more sense here.
  belongs_to :user
  belongs_to :status

  validates_presence_of :status, :name, :user

  # UID and SID are used to lookup the proper User and Statues when creating the Ticket. This needs to be done because HTML stores selections as strings
  attr_accessor :uid, :sid
  attr_accessible :description, :name, :uid, :sid, :user, :status

end
