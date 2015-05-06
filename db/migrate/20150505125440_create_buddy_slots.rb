class CreateBuddySlots < ActiveRecord::Migration
  def change
    create_table :buddy_slots do |t|

      t.timestamps
    end
  end
end
