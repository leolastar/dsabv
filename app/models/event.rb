require 'elasticsearch/model'

class Event < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

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

# Delete the previous articles index in Elasticsearch
Event.__elasticsearch__.client.indices.delete index: Event.index_name rescue nil

# Create the new index with the new mapping
Event.__elasticsearch__.client.indices.create \
  index: Event.index_name,
  body: { settings: Event.settings.to_hash, mappings: Event.mappings.to_hash }

Event.import # for auto sync model with elastic search

