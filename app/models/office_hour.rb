class OfficeHour < ActiveRecord::Base
  named_scope :current, lambda { { :conditions => [ "day_of_week = :day_of_week && start_time <= :now_time && end_time > :now_time", { :day_of_week => Time.zone.now.wday, :now_time => Time.zone.now.strftime("%H:%M:%S") } ] } }
  named_scope :up_to_day, lambda { |value| { :conditions => [ "day_of_week <= ?", value ] } }
  named_scope :chronological, :order => "day_of_week, start_time"

  belongs_to :client
  belongs_to :user

  validates_numericality_of :day_of_week

  attr_accessor :delete_me

  def before_validation_on_create
    self.day_of_week = 6 unless( day_of_week )
    self.start_time = "18:30" unless( start_time )
    self.end_time = "19:30" unless( end_time )
  end

  def date
    Time.zone.now.beginning_of_week + day_of_week.days
  end

  def time_string
    start_time.strftime("%H:%M:%S") + " - " + end_time.strftime("%H:%M:%S")
  end

  def length_in_hours
    ( end_time - start_time ).to_f / 3600
  end
end
