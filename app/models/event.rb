class Event < ActiveRecord::Base
  has_many :time_slots, dependent: :destroy
  has_many :users, through: :time_slots

  def send_event_register_email
    EventMailer.event_register_notification(self).deliver
  end

  settings index: { number_of_shards: 1} do
    mappings dynamic: 'false' do
      indexes :title, analyzer: 'english'
      indexes :place, analyzer: 'english'
      indexes :description, analyzer: 'keyword'
    end
  end
end
