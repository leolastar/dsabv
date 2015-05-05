class BuddyWalk < ActiveRecord::Base
  has_one :buddy_slot, dependent: :destroy
  has_many :users, through: :buddy_slot
	validates :date, presence: true

	def send_event_register_email
		EventMailer.event_register_notification(self).deliver
	end

	def self.search(search)
		where('lower(title) LIKE ? OR lower(place) LIKE ? OR lower(description) LIKE ?', 
			"%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%")
	end
end

  