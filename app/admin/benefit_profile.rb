ActiveAdmin.register BenefitProfile do

 menu parent: "Companies"

  # Edit fields to save
  permit_params :name, :provider, :provider_plan, :benefit_type

  # Index existent info could be here

  # form
  form do |f|
    f.inputs "Benefit Details" do
      # f.input :name, label: 'Provider Co. Name', :placeholder => "(i.e. BCBS)"
      # EE must be attached to an existent Company
      f.input :company_id, as: :select, collection: Company.all.map{|c| ["#{c.name}", c.id]}
      f.input :provider, as: :select, :collection => [['BCBS'], ['Delta']]
      f.input :provider_plan, as: :select, :collection => [['Bronze'],['Silver']]
      f.input :benefit_type, as: :select, :collection => [['Medical'], ['Dental']]
    end
    f.actions
  end
end
