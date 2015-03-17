json.array!(@granites) do |granite|
  json.extract! granite, :id, :name, :image
  json.url granite_url(granite, format: :json)
end
