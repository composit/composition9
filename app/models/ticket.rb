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
