class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :user_id
      t.integer :time_slot_id
      t.boolean :is_checkedin

      t.timestamps
    end

    User.find_each {|user|
	    user.time_slots.each do |slot|
	      Appointment.create!(:user_id => user.id, :time_slot_id => slot.id, :is_checkedin => false )
	    end
  	}

	  # finally, dump the old hatbm associations
	  drop_table :time_slots_users
  end
end
