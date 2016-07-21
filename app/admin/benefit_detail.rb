ActiveAdmin.register BenefitDetail do

# menu parent: "Benefit Profiles"
# belongs_to :benefit_profile
belongs_to :employee

permit_params :employee_category, :benefit_method, :employee_id, :benefit_profile_id, 
  :category_sub, :category_dep, :category_sps, :category_ch_pls_one, :category_sps_pls_one

# index details to benefit_profile
index do
    selectable_column
    column :benefit_profile_id
    column :employee_id
    id_column
    column :category_sub
    column :category_dep
    column :category_sps
    column :category_ch_pls_one
    column :category_sps_pls_one
    
    actions
  end


# form
  form do |f|
      f.inputs "Benefit Details" do
      # f.input :name, label: 'Provider Co. Name', :placeholder => "(i.e. BCBS)"
      
      # f.input Employee.find(resource.employee_id).name, readonly: true, label: 'Name'
      f.input :benefit_profile_id, as: :select, collection: BenefitProfile.where(company_id: Employee.find(resource.employee_id).company_id).map{|b| ["#{b.company_id} #{b.provider} #{b.provider_plan}", b.id]}
      f.input :employee_category, as: :select, :collection => [['1 Employee'], ['2 Manager'], ['3 Owner']]
      f.input :category_sub
      f.input :category_dep
      f.input :category_sps
      f.input :category_ch_pls_one
      f.input :category_sps_pls_one

    end
    f.actions
  end
end
