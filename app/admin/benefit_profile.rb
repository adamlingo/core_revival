ActiveAdmin.register BenefitProfile do

 menu priority: 6
 belongs_to :company

  # Edit fields to save
  permit_params :name, :company_id, :provider, :provider_plan, :benefit_type, :benefit_method, :effective_date

  # Index view of benefits
  index do
    selectable_column
    column :company_id
    id_column
    column :provider
    column :provider_plan
    column :benefit_type
    column :benefit_method
    column :effective_date
    actions dropdown: true do |benefit_profile|
      item "Employees", admin_company_employees_path
      item "Benefit Details", admin_benefit_profile_benefit_details_path(benefit_profile)
      item "Return to Companies", admin_companies_path
    end
  end

  filter :provider
  filter :provider_plan
  filter :benefit_type
  filter :benefit_method
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  # form
  form do |f|
    f.inputs "Benefit Profile" do
      # f.input :name, label: 'Provider Co. Name', :placeholder => "(i.e. BCBS)"
      f.input :company_id, as: :select, collection: Company.all.map{|c| ["#{c.name}", c.id]}
      f.input :provider, as: :select, :collection => [['BCBS'], ['Delta'], ['Principal']]
      f.input :provider_plan, as: :select, :collection => [['Bronze'],['Silver'], ['Gold'], ['Primary']]
      f.input :benefit_type, as: :select, :collection => [['Medical'], ['Dental'],['Life']]
      f.input :benefit_method, as: :select, :collection => [['%'], ['FIXED'], ['Salary Match']]
      f.input :effective_date
    end
    f.actions
  end
end
