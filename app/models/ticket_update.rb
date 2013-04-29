class TicketUpdate < ActiveRecord::Base
  # I feel like has_one should make more sense here.
  belongs_to :ticket
  has_one :status
  has_one :user, as: :owner
  has_one :user, as: :updater

  validates_presence_of :updater, :ticket, :revision, :description

  # Status and owner are optional, required only to show a change
  # time_logged would otherwise be 0, if there's 'no change'
  # Revision needs to be auto-incremented, but localized per ticket (which would be tougher in the DB than in rails)

  attr_accessible :ticket, :revision, :description, :time_logged
end
