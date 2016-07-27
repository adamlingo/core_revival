json.array!(@health_invoices) do |health_invoice|
  json.extract! health_invoice, :id
  json.url health_invoice_url(health_invoice, format: :json)
end
