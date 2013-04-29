class TicketUpdate < ActiveRecord::Base
  # I feel like has_one should make more sense here.
  belongs_to :ticket
  belongs_to :status
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
  belongs_to :updater, :class_name => "User", :foreign_key => "updater_id"
  #belongs_to :updater

  # Things that are definitely required
  validates_presence_of :updater, :ticket, :revision, :description, :time_logged

  # Status and owner are optional, required only to show a change
  # time_logged would otherwise be 0, if there's 'no change'
  #
  # Revision needs to be auto-incremented, but localized per ticket (which would be tougher in the DB than in rails)

  attr_accessor :oid, :sid
  #, :ticket, :revision, :description, :time_logged, :updater, :owner
  attr_accessible :ticket, :revision, :description, :time_logged, :updater, :owner, :status
end
