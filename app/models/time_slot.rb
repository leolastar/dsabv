class TimeSlot < ActiveRecord::Base
  belongs_to :event
  validate :event_id, presence: true

# A time slot of an event can be registered by many users
  has_many :appointments
  has_many :users, through: :appointments

  default_scope -> { order(start_time: :asc) }
end
