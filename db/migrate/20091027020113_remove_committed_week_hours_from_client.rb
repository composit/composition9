class RemoveCommittedWeekHoursFromClient < ActiveRecord::Migration
  def self.up
    remove_column :clients, :committed_week_hours
  end

  def self.down
    add_column :clients, :committed_week_hours, :integer
  end
end
