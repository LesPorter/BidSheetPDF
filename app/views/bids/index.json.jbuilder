json.array!(@bids) do |bid|
  json.extract! bid, :id, :logo, :client_name, :project_name, :date, :cabinet_cost, :granite_cost, :tax_cost, :total_cost, :conditions, :cabinet_mix
  json.url bid_url(bid, format: :json)
end
