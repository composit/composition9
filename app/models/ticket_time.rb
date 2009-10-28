class TicketTime < ActiveRecord::Base
  named_scope :uninvoiced, :conditions => "invoice_id is null"
  named_scope :before_date, lambda { |value| { :conditions => [ "start_time <= ?", value.strftime("%Y-%m-%d %H:%M:%S") ] } }

  belongs_to :ticket
  belongs_to :user
  belongs_to :invoice

  validates_presence_of :ticket_id, :user_id, :start_time
  validates_presence_of :end_time, :on => :update

  def before_validation_on_create
    self.start_time = Time.zone.now unless start_time
  end

  def minutes_worked
    current_end_time = ( end_time ? end_time : Time.zone.now )
    ( current_end_time - start_time ) / 60
  end

  def hours_worked
    minutes_worked / 60
  end

  def dollars
    if( ticket.project.client_id == 2 )
      hours_worked * 30
    else
      hours_worked * ticket.project.hourly_billing_rate
    end
  end

  def self.week_start_time(time)
    date = time.to_date
    if date.wday == 0 #sunday
      start_date = date
    else
      start_date = date.beginning_of_week - 1.day
    end
    start_date.to_time
  end

  def self.week_end_time(time)
    end_date = week_start_time(time).to_date + 7.days
    end_date.to_time
  end
end
