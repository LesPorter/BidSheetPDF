json.array!(@cabinets) do |cabinet|
  json.extract! cabinet, :id, :name, :image, :specs
  json.url cabinet_url(cabinet, format: :json)
end
