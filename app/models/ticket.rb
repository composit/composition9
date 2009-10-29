class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :created_by_user, :class_name => "User"
  has_many :ticket_comments
  has_many :ticket_times
  has_many :alerts
  belongs_to :worker, :class_name => "User"

  validates_presence_of :project_id, :created_by_user_id, :description
  validates_numericality_of :estimated_hours, :allow_nil => true

  def close_me=(close)
    self.closed_date = Time.zone.now
  end

  def before_validation_on_create
    self.worker_id = project.client.workers.first.user.id unless worker_id if project
  end

  def full_description
    project.client.name + ": " + project.title + ": " + description
  end

  def minutes_worked(week_of = nil, user_id = nil)
    TicketTime.sum_minutes_worked( { :ticket_id => id, :week_of => week_of, :user_id => user_id } )
=begin
    conditions_string = "1"
    conditions_hash = Hash.new
    if week_of
      conditions_string += " and start_time >= :week_start_time and start_time < :week_end_time"
      conditions_hash.merge!( { :week_start_time => TicketTime.week_start_time(week_of).utc, :week_end_time => TicketTime.week_end_time(week_of).utc } )
    end
    if user_id
      conditions_string += " and user_id = :user_id"
      conditions_hash.merge!( { :user_id => user_id } )
    end
    ticket_times.find(:all, :conditions => [ conditions_string, conditions_hash ]).inject(0) { |total_minutes, ticket_time| total_minutes + ticket_time.minutes_worked }
=end
  end

  def hours_worked(week_of = nil, user_id = nil)
    minutes_worked(week_of, user_id) / 60
  end

  def open_hours
    hours = estimated_hours - hours_worked
    hours > 0 ? hours : 0
  end

  def new_ticket_comment(user_id)
    TicketComment.new( :ticket_id => id, :user_id => user_id )
  end

  def unbilled_ticket_times
    ticket_times.find( :all, :conditions => "invoice_id is null and end_time is not null" )
  end

  def closed?
    closed_date != nil
  end
end
