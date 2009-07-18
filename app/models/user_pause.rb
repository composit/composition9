class UserPause < ActiveRecord::Base
  belongs_to :user
  belongs_to :pause

  validates_presence_of :user_id, :pause_id, :start_time

  def before_validation_on_create
    self.start_time = Time.zone.now unless start_time
  end

  def before_validation_on_update
    self.end_time = Time.zone.now unless end_time
  end

  def after_update
    if (end_time - start_time) / 60 > pause.allowed_length
      paused_ticket_time = user.open_ticket_time
      user.open_ticket_time.update_attributes( :end_time => start_time + pause.allowed_length.minutes )
      TicketTime.create( :ticket_id => paused_ticket_time.ticket_id, :user_id => user.id, :start_time => Time.zone.now )
    end
  end

  def overdue?
    unless end_time
      overdue = ( start_time + pause.allowed_length.minutes - 1.minute <= Time.zone.now )
    else
      overdue = false
    end
    overdue
  end

  def urgency_class
    if overdue?
      u_class = "urgency_1"
    else
      u_class = "urgency_2"
    end
    u_class
  end
end
