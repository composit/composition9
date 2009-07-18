class AddPriorityToProjectsAndTickets < ActiveRecord::Migration
  def self.up
    add_column :projects, :priority, :integer
    add_column :tickets, :priority, :integer
  end

  def self.down
    remove_column :projects, :priority
    remove_column :tickets, :priority
  end
end
