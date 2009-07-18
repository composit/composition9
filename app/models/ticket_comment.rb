class TicketComment < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
  has_many :alerts

  validates_presence_of :ticket_id, :user_id, :comment
end
