class Event < ActiveRecord::Base
  has_many :time_slots, dependent: :destroy
  has_many :users, through: :time_slots

  def send_event_register_email
    EventMailer.event_register_notification(self).deliver
  end

  def self.search(search)
  	where('title LIKE ? OR place LIKE ? OR description LIKE ?', 
  		"%#{search}%", "%#{search}%", "%#{search}%")
  end
end

