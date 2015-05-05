class AddStartTimeToBuddySlots < ActiveRecord::Migration
  def change
    add_column :buddy_slots, :start_time, :datetime
    add_column :buddy_slots, :end_time, :datetime
  end
end
