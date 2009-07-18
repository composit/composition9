class CreatePauses < ActiveRecord::Migration
  def self.up
    create_table :pauses do |t|
      t.string :title
      t.integer :interval
      t.integer :allowed_length

      t.timestamps
    end
  end

  def self.down
    drop_table :pauses
  end
end
