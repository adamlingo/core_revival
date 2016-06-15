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
      f.input :employee_category, as: :select, :collection => [['1'], ['2'], ['3'], ['4']]
      f.input :benefit_category, as: :select, :collection => [['SUB'], ['DEP'], ['SPS'], ['CH+1'], ['SPS+1']]
      f.input :employer_pay_type, as: :select, :collection => [['%'], ['$']]
      f.input :benefit_amount, :placeholder => "Benefit Amount"
    end
    f.actions
  end
end
