class ChangeOfficeHours < ActiveRecord::Migration
  def self.up
    remove_column :office_hours, :start_hour
    remove_column :office_hours, :start_minute
    remove_column :office_hours, :end_hour
    remove_column :office_hours, :end_minute
    add_column :office_hours, :start_time, :time
    add_column :office_hours, :end_time, :time
  end

  def self.down
    add_column :office_hours, :start_hour, :integer
    add_column :office_hours, :start_minute, :integer
    add_column :office_hours, :end_hour, :integer
    add_column :office_hours, :end_minute, :integer
    remove_column :office_hours, :start_time
    remove_column :office_hours, :end_time
  end
end
