json.array!(@benefit_profiles) do |benefit_profile|
  json.extract! benefit_profile, :id, :name, :company_id
  json.url benefit_profile_url(benefit_profile, format: :json)
end
