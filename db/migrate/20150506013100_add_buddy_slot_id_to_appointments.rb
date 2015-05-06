class AddBuddySlotIdToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :buddy_slot_id, :integer
  end
end
