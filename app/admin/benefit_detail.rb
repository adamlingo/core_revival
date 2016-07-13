ActiveAdmin.register BenefitDetail do

# menu parent: "Benefit Profiles"
# belongs_to :benefit_profile
belongs_to :employee

permit_params :employee_category, :benefit_category, :benefit_amount, :benefit_method, :employee_id, :benefit_profile_id

# index details to benefit_profile
index do
    selectable_column
    column :benefit_profile_id
    column :employee_id
    id_column
    
    # column :provider
    actions
  end


# form
  form do |f|
      f.inputs "Benefit Details" do
      # f.input :name, label: 'Provider Co. Name', :placeholder => "(i.e. BCBS)"
      
      f.input :employee_id, label: 'Name'
      #f.input :benefit_profile_id, as: :select, collection: BenefitProfile.where(company_id: Employee.find(:employee_id).company_id).map{|b| ["#{b.company_id} #{b.provider} #{b.provider_plan}", b.id]}
      f.input :employee_category, as: :select, :collection => [['1 Employee'], ['2 Manager'], ['3 Owner']]
      f.input :benefit_category, as: :select, :collection => [['SUB'], ['DEP'], ['SPS'], ['CH+1'], ['SPS+1']]
      f.input :benefit_method, as: :select, :collection => [['%'], ['$']]
      f.input :benefit_amount

    end
    f.actions
  end
end
