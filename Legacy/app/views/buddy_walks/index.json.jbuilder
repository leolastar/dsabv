json.array!(@buddy_walks) do |buddy_walk|
  json.extract! buddy_walk, :id, :title, :place, :description
  json.url buddy_walk_url(buddy_walk, format: :json)
end
