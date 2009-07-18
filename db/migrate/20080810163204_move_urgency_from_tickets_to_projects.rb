class MoveUrgencyFromTicketsToProjects < ActiveRecord::Migration
  def self.up
    remove_column :tickets, :urgency
    add_column :projects, :urgency, :integer
  end

  def self.down
    add_column :tickets, :urgency, :integer
    remove_column :projects, :urgency
  end
end
