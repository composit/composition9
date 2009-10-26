class OfficeHour < ActiveRecord::Base
  named_scope :current, :conditions => [ "day_of_week = :day_of_week && start_time <= :now_time && end_time > :now_time", { :day_of_week => Time.now.wday, :now_time => Time.zone.now.strftime("%H:%M:%S") } ]

  belongs_to :client
  belongs_to :user

  validates_numericality_of :start_hour, :start_minute, :end_hour, :end_minute, :day_of_week

  def start_time_string
    start_time.strftime("%H:%M:%S")
  end

  def end_time_string
    end_time.strftime("%H:%M:%S")
  end

  def time_string
    start_time_string + " - " + end_time_string
  end
end
