class Appointment < ActiveRecord::Base
	belongs_to :time_slot
	belongs_to :user
end
