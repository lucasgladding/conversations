json.array!(@conversations) do |conversation|
  json.extract! conversation, :topic, :creator_id
  json.url conversation_url(conversation, format: :json)
end