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

  def self.sum_minutes_worked( attributes ) # [ client_id, project_id, ticket_id, week_of, user_id ] - need one of client_id/project_id/ticket_id
    conditions_string = "select SUM( TIMESTAMPDIFF(SECOND,start_time,end_time) ) as seconds from ticket_times left join tickets on ticket_times.ticket_id = tickets.id left join projects on tickets.project_id = projects.id where end_time not NULL"
    conditions_hash = Hash.new
    if( attributes[:client_id] )
      conditions_string += " and projects.client_id = :client_id"
      conditions_hash.merge!( { :client_id => attributes[:client_id] } )
    end
    if( attributes[:project_id] )
      conditions_string += " and tickets.project_id = :project_id"
      conditions_hash.merge!( { :project_id => attributes[:project_id] } )
    end
    if( attributes[:ticket_id] )
      conditions_string += " and ticket_times.ticket_id = :ticket_id"
      conditions_hash.merge!( { :ticket_id => attributes[:ticket_id] } )
    end
    if( attributes[:week_of] )
      conditions_string += " and start_time >= :week_start_time and start_time < :week_end_time"
      conditions_hash.merge!( { :week_start_time => TicketTime.week_start_time(attributes[:week_of]).utc, :week_end_time => TicketTime.week_end_time(attributes[:week_of]).utc } )
    end
    if( attributes[:user_id] )
      conditions_string += " and user_id = :user_id"
      conditions_hash.merge!( { :user_id => attributes[:user_id] } )
    end
    if( attributes[:client_id] )
      conditions_string += " GROUP BY client_id"
    elsif( attributes[:project_id] )
      conditions_string += " GROUP BY project_id"
    elsif( attributes[:ticket_id] )
      conditions_string += " GROUP BY ticket_id"
    end
    ticket_time = self.find_by_sql( [ conditions_string, conditions_hash ] )
    minutes = ticket_time[0] ? ticket_time[0].seconds.to_f / 60 : 0
    if( unfinished_ticket = self.ticket_times.find( :first, :conditions => { :end_time => nil } )
      minutes += ( ( Time.zone.now - unfinished_ticket.start_time ).to_f / 60 )
    end
    return minutes
  end
end
