class OfficeHour < ActiveRecord::Base
  named_scope :current, :conditions => [ "day_of_week = :day_of_week && start_time <= :now_time && end_time > :now_time", { :day_of_week => Time.now.wday, :now_time => Time.now.strftime("%H-%m-%s") } ]

  belongs_to :client
  belongs_to :user

  validates_numericality_of :start_hour, :start_minute, :end_hour, :end_minute, :day_of_week

  def start_time_string
    start_hour.to_s + ":" + sprintf("%02d",start_minute)
  end

  def end_time_string
    end_hour.to_s + ":" + sprintf("%02d",end_minute)
  end
end
