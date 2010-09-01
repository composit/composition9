class Invoice < ActiveRecord::Base
  scope :unpaid, :conditions => { :paid_date => nil }

  belongs_to :client
  has_many :ticket_times
  has_many :tickets, :through => :ticket_times
  has_many :invoice_adjustment_lines

  validates_presence_of :client_id, :invoice_date

  before_destroy :unset_tickets

  def invoice_number
    sprintf("%03d", client.id.to_s) + invoice_date.strftime('%y%m') + sprintf("%03d", id.to_s)
  end

  def total_amount
    hourly_total = ticket_times.inject(0) do |total, ticket_time|
      total.to_f + ticket_time.dollars.to_f if ticket_time.ticket.project.billing_rate_unit == 'hour'
    end
    monthly_total = client.billing_rate_dollars if client.billing_rate_unit == 'month'
    subtotal = hourly_total.to_i + monthly_total.to_i
    adjustment_total = invoice_adjustment_lines.inject(0) do |total, invoice_adjustment_line|
      total.to_f + invoice_adjustment_line.amount.to_f
    end
    subtotal + adjustment_total
  end

  def include_ticket_times=( times )
    times.each do |idx, value|
      ticket_times << TicketTime.find( idx ) if value == '1'
    end
  end

  def projects
    project_array = Array.new
    tickets.each do |ticket|
      project_array << ticket.project
    end
    project_array.uniq
  end

  def project_details( project_id )
    dollars = 0
    minutes = 0
    Project.find( project_id ).tickets.each do |ticket|
      ticket.ticket_times.where( "invoice_id = :invoice_id", { :invoice_id => id } ).each do |ticket_time|
        minutes += ticket_time.minutes_worked
        dollars += ticket_time.dollars
      end
    end
    hours = minutes / 60
    { :hours => hours, :dollars => dollars }
  end

  def payment_status
    if paid_date
      status = "paid"
    elsif invoice_date < 1.month.ago.to_date
      status = "overdue"
    else
      status = "unpaid"
    end
    status
  end

  private
    def unset_tickets
      ticket_times.each { |ticket_time| ticket_time.update_attribute( :invoice_id, nil ) }
    end
end
