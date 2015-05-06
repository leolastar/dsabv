class AddBuddyWalkRefToBuddySlots < ActiveRecord::Migration
  def change
    add_reference :buddy_slots, :buddy_walk, index: true
  end
end
