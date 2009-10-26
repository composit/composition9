class OfficeHour < ActiveRecord::Base
  named_scope :current, :conditions => [ "day_of_week = :day_of_week && start_time <= :now_time && end_time > :now_time", { :day_of_week => Time.now.wday, :now_time => Time.now.strftime("%H:%M:%S") } ]

  belongs_to :client
  belongs_to :user

  validates_numericality_of :day_of_week

  def date
    Time.now.beginning_of_week + day_of_week.days
  end

  def time_string
    start_time.strftime("%H:%M:%S") + " - " + end_time.strftime("%H:%M:%S")
  end
end
