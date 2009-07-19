class OfficeHour < ActiveRecord::Base
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
