class CreateBudgetAdjustments < ActiveRecord::Migration
  def self.up
    create_table :budget_adjustments do |t|
      t.decimal :amount, :precision => 10, :scale => 2
      t.integer :user_id
      t.string :description
      t.date :adjustment_date

      t.timestamps
    end
  end

  def self.down
    drop_table :budget_adjustments
  end
end
