class Event < ActiveRecord::Base
  has_many :time_slots, dependent: :destroy

  def send_event_register_email
    EventMailer.event_register_notification(self).deliver
  end
end
