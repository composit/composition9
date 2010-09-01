class Client < ActiveRecord::Base
	scope :alphabetical, :order => :name

  has_many :client_users
  has_many :users, :through => :client_users
  has_many :invoices
  has_many :projects
  has_many :tickets, :through => :projects
  has_many :alerts
  has_many :office_hours

  validates_presence_of :name, :address_line_1, :city, :state, :zip
  validates_format_of :zip, :with => /\A\d{5}[-\d{4}]*\Z/

  attr_accessor :expanded_project

  before_create :set_active

  def minutes_worked( week_of = nil, user_id = nil )
    # projects.inject(0) { |total_minutes, project| total_minutes + project.minutes_worked(week_of, user_id) }
    TicketTime.sum_minutes_worked( { :client_id => id, :week_of => week_of, :user_id => user_id } )
  end

  def hours_worked(week_of = nil, user_id = nil)
    minutes_worked(week_of, user_id) / 60
  end

  def committed_week_hours( day = 6 )
    office_hours.up_to_day( day ).inject(0){ |sum, office_hour| sum + office_hour.length_in_hours }
  end

  def hours_left_this_week
    hours_left = committed_week_hours( Time.zone.now.wday ) - hours_worked( Time.zone.now )
    hours_left > 0 ? hours_left : 0
  end

  def workers
    client_users.where( "is_worker = 1" )
  end

  def open_projects(urgency = nil)
    conditions_string = "closed_date is null"
    conditions_hash = Hash.new
    if urgency
      conditions_string += " and urgency = :urgency"
      conditions_hash.merge!( { :urgency => urgency } )
    end
    projects.where( conditions_string, conditions_hash ).order( "priority" )
  end

  def closed_projects
    projects.where( "closed_date is not null" ).order( "closed_date DESC" )
  end

  def open_hours(urgency = nil)
    logger.info("loading open hours " + urgency.to_s)
    conditions_string = "closed_date is null"
    conditions_hash = Hash.new
    if urgency
      conditions_string += " and urgency = :urgency"
      conditions_hash.merge!( { :urgency => urgency } )
    end
    logger.info("almost done loading open hours " + urgency.to_s)
    projects.where( conditions_string, conditions_hash ).inject(0) { |total_hours, project| total_hours + project.open_hours }
  end

  def new_project(user_id, urgency)
    priority = ( open_projects(urgency).last ? priority = open_projects(urgency).last.priority + 1 : 0 )
    Project.new(
      :client_id => id,
      :created_by_user_id => user_id,
      :billing_rate_dollars => billing_rate_dollars,
      :billing_rate_unit => billing_rate_unit, 
      :priority => priority,
      :urgency => urgency
    )
  end

  def unbilled_ticket_times
    ticket_times = Array.new
    projects.each do |project|
      ticket_times += project.unbilled_ticket_times
    end
    ticket_times
  end

  def total_unpaid_invoice_value
    invoices.unpaid.inject(0) { |total, invoice| total + invoice.total_amount }
  end

  def invoice_span_start
    start = Time.zone.now - invoice_span.weeks if( invoice_span_units == "weeks" )
    start = Time.zone.now - invoice_span.months if( invoice_span_units == "months" )
    start
  end

  def overdue_for_invoicing?
    tickets.each do |ticket|
      return true if( ticket.ticket_times.uninvoiced.before_date( invoice_span_start ).length > 0 && billing_rate_unit != "never" )
    end
    return false
  end

  private
    def set_active
      self.active = true
    end
end
