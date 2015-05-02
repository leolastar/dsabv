class AddClassSlotIdToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :class_slot_id, :integer
  end
end
