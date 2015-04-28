json.array!(@ds_classes) do |ds_class|
  json.extract! ds_class, :id, :title, :place, :description, :start_time, :end_time, :start_date, :end_date
  json.url ds_class_url(ds_class, format: :json)
end
