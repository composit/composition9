require 'digest/sha1'
class User < ActiveRecord::Base
  # Virtual attribute for the unencrypted password
  attr_accessor :password

  scope :admin, :conditions => { :is_admin => true }
	scope :alphabetical, :order => :login

  has_many :client_users
  has_many :clients, :through => :client_users
  has_many :created_tickets, :class_name => "Ticket", :foreign_key => :created_by_user_id
  has_many :working_tickets, :class_name => "Ticket", :foreign_key => :worker_id
  has_many :ticket_comments
  has_many :ticket_times
  has_many :pauses
  has_many :user_pauses
  has_many :alerts
  has_many :user_alerts
  has_many :office_hours
  has_many :budget_adjustments

  validates_presence_of     :login, :email, :phone
  validates_numericality_of :phone
  validates_length_of       :phone, :is => 10
  validates_format_of       :zip, :with => /\A\d{5}[-\d{4}]*\Z/, :allow_blank => true
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_length_of       :login,    :within => 3..40
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :login, :email, :case_sensitive => false
  before_save :encrypt_password
  before_create :make_activation_code 
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :password, :password_confirmation, :phone, :address_line_1, :address_line_2, :city, :state, :zip, :is_admin, :time_zone, :office_hour_attributes, :number_of_office_hours_to_add

  before_validation do
    phone.gsub!(/\D/, '') if phone
  end

  # Activates the user in the database.
  def activate
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    save(false)
  end

  def active?
    # the existence of an activation code means they have not activated yet
    activation_code.nil?
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    u = first( :conditions => ['login = ? and activated_at IS NOT NULL', login] ) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    remember_me_for 2.weeks
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    self.remember_token_expires_at = time
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  def belongs_to_client?(client_id)
    client_users.first( :conditions => [ "client_id = ?", client_id ] )
  end

  def is_client_admin?(client_id)
    client_users.first( :conditions => [ "client_id = ? && is_admin = 1", client_id ] )
  end

  def is_worker_for_client?(client_id)
    client_users.first( :conditions => [ "client_id = ? && is_worker = 1", client_id ] )
  end

  def can_view_client_invoices?(client_id)
    client_users.first( :conditions => [ "client_id = ? && can_view_invoices = 1", client_id ] )
  end

  def is_worker?
    client_users.first( :conditions => "is_worker = 1" )
  end

  def active_clients( client_active = true )
    clients = []
    client_users.where( "is_worker = 1" ).order( "priority" ).each { |client_user| clients << client_user.client if client_user.client.active == client_active }
    clients
  end

  def open_ticket_time
    ticket_times.first( :conditions => "end_time is null" )
  end

  def open_user_pause
    user_pauses.first( :conditions => "end_time is null" )
  end

  def hours_worked(week_of)
    active_clients.inject(0) { |total_minutes, client| total_minutes + client.minutes_worked(week_of, id) } / 60
  end

  def hours_left_this_week
    active_clients.inject(0) { |total_hours, client| total_hours + client.hours_left_this_week }
  end

  def speculative_hours_left_this_week
    WEEK_HOUR_ESTIMATE - hours_worked( Time.zone.now )
  end

  def open_hours(urgency = nil)
    active_clients.inject(0) { |total_hours, client| total_hours + client.open_hours(urgency) }
  end

  def dollars_earned(week_of = nil)
    if week_of
      conditions = [ "start_time >= :week_start_time and start_time < :week_end_time", { :week_start_time => TicketTime.week_start_time(week_of).utc, :week_end_time => TicketTime.week_end_time(week_of).utc } ]
    end
    ticket_times.where( conditions ).inject(0) { |total_dollars, ticket_time| total_dollars + ticket_time.dollars }
  end

  def new_ticket_time(ticket_id)
    TicketTime.new( :ticket_id => ticket_id, :user_id => id )
  end

  def next_ticket
    logger.info("getting next ticket")
    highest_priority_ticket = false
    (1..3).each do |urgency|
      (0..1).each do |hours_left|
        prioritized_client_users.each do |client_user|
          if client_user.client.hours_left_this_week > hours_left * -1 && client_user.client.active
            client_user.client.projects.where( "closed_date is null && urgency = ?", urgency ).order( "priority" ).each do |project|
              project.tickets.where( "worker_id = :worker_id && closed_date is null", { :worker_id => id } ).order( "priority" ).each do |ticket|
                highest_priority_ticket = ticket unless highest_priority_ticket
              end unless highest_priority_ticket
            end unless highest_priority_ticket
          end unless highest_priority_ticket
        end unless highest_priority_ticket
      end unless highest_priority_ticket
    end unless highest_priority_ticket
    logger.info("done getting next ticket")
    highest_priority_ticket
  end

  def prioritized_client_users
    logger.info("loading current office hour")
    p_c_users = client_users.prioritized
    if( office_hour = office_hours.current.first )
      p_c_users = p_c_users.reject{ |client_user| client_user.client_id == office_hour.client_id }.unshift( client_users.find_by_client_id( office_hour.client_id ) )
    end
    logger.info("done loading current office hour")
    p_c_users
  end

  def active_alerts
    active_user_alerts.collect { |user_alert| user_alert.alert }
  end

  def active_user_alerts
    user_alerts.where( "hidden_time is null" )
  end

  def committed_week_hours
    active_clients.inject(0) { |total_hours, client| total_hours + client.committed_week_hours }
  end

  def hours_on_track
    ( committed_week_hours - hours_left_this_week > committed_week_hours / 5 * Date.today.wday ) && open_hours(1) == 0
  end

  def speculative_hours_on_track
    hours_worked( Time.zone.now ) > WEEK_HOUR_ESTIMATE / 5 * Date.today.wday
  end

  def dollars_on_track
    dollars_earned(Time.zone.now) > WEEK_DOLLAR_ESTIMATE / 5 * Date.today.wday
  end

  def percent_hours_this_week
    if committed_week_hours == 0
      return 0
    else
      hours_done_this_week = committed_week_hours - hours_left_this_week
      return hours_done_this_week.to_f / committed_week_hours.to_f
    end
  end

  def percent_dollars_this_week
    dollars_earned(Time.zone.now).to_f / WEEK_DOLLAR_ESTIMATE.to_f
  end

  def dollars_remaining_this_week( day = 6 )
    dollars_remaining = ( WEEK_DOLLAR_ESTIMATE / 5 * Date.today.wday ) - dollars_earned( Time.zone.now )
    dollars_remaining < 0 ? 0 : dollars_remaining
  end

  def total_percent_this_week
    # ( ( percent_hours_this_week + percent_dollars_this_week ) / 2 * 100 ).round
    # ( percent_hours_this_week * 100 ).round
    ( hours_worked( Time.zone.now ) / WEEK_HOUR_ESTIMATE * 100 ).round
  end

  def office_hour_attributes=( attributes )
    attributes.each do |index, office_hour_attributes|
      if( office_hour = office_hours.find_by_id( office_hour_attributes[ :id ] ) )
        office_hour.update_attributes( office_hour_attributes )
      end
    end
  end

  def number_of_office_hours_to_add
    0
  end

  def number_of_office_hours_to_add=( number )
    number.to_i.times { OfficeHour.create( :user_id => id ) }
  end

  def budget_track( track_date )
    start_date = track_date.beginning_of_year
    end_date = track_date + 24.hours
    conditions = [ "start_time >= ? AND start_time <= ?", start_date, end_date ]
    day = ( track_date.wday > 5 ? 5 : track_date.wday )
    budget = ( ( track_date.strftime( "%U" ).to_i - 1 ) * WEEK_DOLLAR_ESTIMATE ) + ( day * WEEK_DOLLAR_ESTIMATE / 5 )
    dollars = ticket_times.where( "start_time >= ? AND start_time <= ?", start_date, end_date ).inject(0) { |total_dollars, ticket_time| total_dollars + ticket_time.dollars }
    adjustments = budget_adjustments.sum( :amount, :conditions => [ "adjustment_date >= ? AND adjustment_date <= ?", start_date, end_date ] )
    return( ( -1 * budget ) + adjustments + dollars )
  end

  protected
    # before filter 
    def encrypt_password
      return if password.blank?
      self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
      self.crypted_password = encrypt(password)
    end
      
    def password_required?
      crypted_password.blank? || !password.blank?
    end
    
    def make_activation_code

      self.activation_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
    end
end
