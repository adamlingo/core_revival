ActiveAdmin.register BenefitProfile do

 menu priority: 5

  # Edit fields to save
  permit_params :name, :company_id, :provider, :provider_plan, :benefit_type

  # Index view of benefits
  index do
    selectable_column
    column :company_id
    id_column
    column :provider
    actions dropdown: true do |benefit_profile|
      item "Employees", admin_employees_path
      item "Return to Company", admin_companies_path
    end
  end

  # form
  form do |f|
    f.inputs "Benefit Details" do
      # f.input :name, label: 'Provider Co. Name', :placeholder => "(i.e. BCBS)"
      f.input :company_id, as: :select, collection: Company.all.map{|c| ["#{c.name}", c.id]}
      f.input :provider, as: :select, :collection => [['BCBS'], ['Delta']]
      f.input :provider_plan, as: :select, :collection => [['Bronze'],['Silver']]
      f.input :benefit_type, as: :select, :collection => [['Medical'], ['Dental']]
      
    end
    f.actions
  end
end
