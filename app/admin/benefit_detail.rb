ActiveAdmin.register BenefitDetail do
menu parent: "Benefit Profiles"

permit_params :employee_category, :benefit_category, :benefit_amount, :benefit_method

# index details to benefit_profile
index do
    selectable_column
    column :benefit_profile_id
    id_column
    
    # column :provider
    actions
  end


# form
  form do |f|
    f.inputs "Benefit Details" do
      # f.input :name, label: 'Provider Co. Name', :placeholder => "(i.e. BCBS)"
      f.input :employee_category, as: :select, :collection => [['1 Employee'], ['2 Manager'], ['3 Owner']]
      f.input :benefit_category, as: :select, :collection => [['SUB'], ['DEP'], ['SPS'], ['CH+1'], ['SPS+1']]
      f.input :benefit_method, as: :select, :collection => [['%'], ['$']]
      f.input :benefit_amount

    end
    f.actions
  end
end
