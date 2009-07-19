class ChangeOfficeHourDayToDayOfWeek < ActiveRecord::Migration
  def self.up
    rename_column :office_hours, :day, :day_of_week
  end

  def self.down
    rename_column :office_hours, :day_of_week, :day
  end
end
