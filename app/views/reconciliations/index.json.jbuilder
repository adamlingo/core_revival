json.array!(@reconciliations) do |reconciliation|
  json.extract! reconciliation, :id
  json.url reconciliation_url(reconciliation, format: :json)
end
