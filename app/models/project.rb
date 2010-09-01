class Project < ActiveRecord::Base
  belongs_to :client
  belongs_to :created_by_user, :class_name => "User"
  has_many :tickets, :dependent => :destroy
  has_many :ticket_times, :through => :tickets
  has_many :alerts

  BILLING_RATE_UNITS = [
    "hour",
    "month",
    "project"
  ]

  validates_presence_of :client_id, :created_by_user_id, :title, :billing_rate_dollars, :billing_rate_unit, :urgency
  validates_numericality_of :billing_rate_dollars, :urgency
  validates_inclusion_of :billing_rate_unit, :in => BILLING_RATE_UNITS, :message => "must be a valid billing rate unit"

  after_create :create_first_ticket
  after_update :close_tickets

  def close_me=(close)
    @close_me = self.closed_date = Date.today if close == '1'
  end

  def close_me
    @close_me
  end

  def minutes_worked(week_of = nil, user_id = nil)
    # tickets.inject(0) { |total_minutes, ticket| total_minutes + ticket.minutes_worked(week_of, user_id) }
    TicketTime.sum_minutes_worked( { :project_id => id, :week_of => week_of, :user_id => user_id } )
  end

  def hours_worked(week_of = nil, user_id = nil)
    minutes_worked(week_of, user_id) / 60
  end

  def hourly_billing_rate
    if billing_rate_unit == "hour"
      rate = billing_rate_dollars
    elsif billing_rate_unit == "month"
      rate = billing_rate_dollars.to_f / ( client.committed_week_hours * 4 )
    else
      rate = 0
    end
    rate
  end

  def open_tickets
    tickets.where( "closed_date is null" )
  end

  def open_hours
    open_tickets.inject(0) { |total_hours, ticket| total_hours + ticket.open_hours }
  end

  def estimated_hours
    tickets.inject(0) { |total_hours, ticket| total_hours + ticket.estimated_hours.to_f }
  end

  def new_ticket(user_id)
    if priority_ticket = tickets.first( :conditions => "closed_date is null", :order => "priority DESC")
      priority = priority_ticket.priority + 1
    else
      priority = 0
    end
    Ticket.new(
      :project_id => id, 
      :created_by_user_id => user_id,
      :estimated_hours => 0,
      :priority => priority,
      :worker_id => client.workers.first.user_id
    )
  end

  def estimated_complete_date
    estimated_hours = 0
    (1..urgency).each do |est_urgency|
      conditions_string = "closed_date is null && urgency = :urgency"
      conditions_hash = { :urgency => est_urgency }
      if est_urgency == urgency
        conditions_string += " && priority <= :priority"
        conditions_hash.merge!({ :priority => priority })
      end
      estimated_hours += client.projects.where( conditions_string, conditions_hash ).order( "priority" ).inject(0) { |total_hours, project| total_hours + project.estimated_hours }
    end
    if client.committed_week_hours == 0
      estimated_weeks = 0
    else
      estimated_weeks = ( estimated_hours / client.committed_week_hours ).ceil
    end
    estimate = Date.today.beginning_of_week - 3.days + (7 * estimated_weeks).days
  end

  def unbilled_ticket_times
    ticket_times = Array.new
    tickets.each do |ticket|
      ticket_times += ticket.unbilled_ticket_times
    end
    ticket_times
  end

  private
    def create_first_ticket
      user = User.find( created_by_user_id )
      unless user.is_admin
        ticket = new_ticket(user.id)
        ticket.description = title
        ticket.save
      end
    end

    def close_tickets
      if closed_date
        tickets.each { |ticket| ticket.update_attribute( "closed_date", closed_date ) unless ticket.closed_date }
      end
    end
end
