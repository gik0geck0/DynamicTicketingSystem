class Ticket < ActiveRecord::Base
  # I feel like has_one should make more sense here.
  belongs_to :user
  belongs_to :status
  has_many :ticket_updates

  validates_presence_of :status, :name, :user

  # UID and SID are used to lookup the proper User and Statues when creating the Ticket. This needs to be done because HTML stores selections as strings
  attr_accessor :uid, :sid
  attr_accessible :description, :name, :uid, :sid, :user, :status

  def get_current_status
    set_latest_update

    if @latest_update
      return @latest_update.status
    else
      return self.status
    end
  end

  def get_current_owner
    set_latest_update

    if @latest_update
      return @latest_update.owner
    else
      return self.user
    end
  end

  def set_latest_update
    if not @latest_update
      @latest_update = TicketUpdate.where(["ticket_id = ?", self.id]).order("created_at").last
    end
  end

end
