class Appointment < ActiveRecord::Base
	belongs_to :time_slot
	belongs_to :user
	belongs_to :class_slot
	belongs_to :buddy_slot
end
