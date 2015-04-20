class Event < ActiveRecord::Base
  has_many :time_slots, dependent: :destroy
  has_many :users, through: :time_slots

  def send_event_register_email
    EventMailer.event_register_notification(self).deliver
  end

  def self.search(search)
  	where("lower(title) LIKE ?", "%#{search.downcase}%")
  	where("lower(place) LIKE ?", "%#{search.downcase}%")
  	where("lower(description) LIKE ?", "%#{search.downcase}%")
  end
end

