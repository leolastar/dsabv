class AddBuddySlotRefToAppointments < ActiveRecord::Migration
  def change
    add_reference :appointments, :buddy_slot, index: true
  end
end
