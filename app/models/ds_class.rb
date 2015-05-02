class DsClass < ActiveRecord::Base
	has_many :class_slots, dependent: :destroy
	has_many :users, through: :class_slots

	def send_event_register_email
		EventMailer.event_register_notification(self).deliver
	end

	def self.search(search)
		where('lower(title) LIKE ? OR lower(place) LIKE ? OR lower(description) LIKE ?', 
			"%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%")
	end
end
