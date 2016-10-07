json.array!(@employee_benefit_selections) do |employee_benefit_selection|
  json.extract! employee_benefit_selection, :id, :employee_id, :benefit_type, :decline_benefit, :benefit_detail_id
  json.url employee_benefit_selection_url(employee_benefit_selection, format: :json)
end
