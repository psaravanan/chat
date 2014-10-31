json.array!(@messages) do |message|
  json.extract! message, :id, :message, :from_id, :to_id
  json.url message_url(message, format: :json)
end
