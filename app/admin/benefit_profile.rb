ActiveAdmin.register BenefitProfile do

 menu priority: 6
 belongs_to :company

  # Edit fields to save
  permit_params :name, :company_id, :provider, :provider_plan, :benefit_type

  # Index view of benefits
  index do
    selectable_column
    column :company_id
    id_column
    column :provider
    column :provider_plan
    column :benefit_type
    actions dropdown: true do |company|
      item "Employees", admin_company_employees_path(company)
      # item "Benefit Details", admin_employee_benefit_details_path(company)
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
