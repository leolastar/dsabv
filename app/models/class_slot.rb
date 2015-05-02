class ClassSlot < ActiveRecord::Base
  has_many :days
  belongs_to :ds_class
  validate :ds_class_id, presence: true

# A time slot of an event can be registered by many users
  has_many :appointments
  has_many :users, through: :appointments

  default_scope -> { order(start_time: :asc) }

  def capacity_left
    self.total_capacity - self.users.count
  end
end

end
