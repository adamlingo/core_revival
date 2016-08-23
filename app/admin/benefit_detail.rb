ActiveAdmin.register BenefitDetail do

# menu parent: "Benefit Profiles"
# belongs_to :benefit_profile
belongs_to :benefit_profile

permit_params :employee_category, :benefit_profile_id, :employee_tier,
  :category_sub, :category_dep, :category_sps, :category_ch_pls_one, :category_sps_pls_one

# index details to benefit_profile
index do
    selectable_column
    column :benefit_profile_id
    id_column
    column :employee_category
    #column :employee_tier
    column :category_sub
    column :category_dep
    column :category_sps
    column :category_ch_pls_one
    column :category_sps_pls_one
    
    actions dropdown: true do
      item "Return to Companies", admin_companies_path
    end
  end


# form
  form do |f|
      f.inputs "Benefit Details" do
      f.input :benefit_profile_id, as: :select, collection: BenefitProfile.where(company_id: BenefitProfile.find(resource.benefit_profile_id).company_id).map{|b| ["#{b.provider} #{b.provider_plan}", b.id]}
      f.input :employee_category, as: :select, :collection => [['1 Employee'], ['2 Manager'], ['3 Owner']]
      #f.input :employee_tier, as: :select, :collection => [['SUB']]
      f.input :category_sub, label: 'SUB Amount'
      f.input :category_dep, label: 'DEP Amount'
      f.input :category_sps, label: 'SPS Amount'
      f.input :category_ch_pls_one, label: 'CH + 1 Amount'
      f.input :category_sps_pls_one, label: 'SPS + 1 Amount'

    end
    f.actions
  end
end
