ActiveAdmin.register LifeBenefitDetail do

belongs_to :benefit_detail

permit_params :benefit_detail_id, :subscriber_cap, :subscriber_increment, :spouse_cap, 
	:spouse_increment, :dependent_coverage, :dependent_rate

# index details to life_benefit_detail
  index do
    selectable_column
    column :benefit_detail_id
    id_column
    column :subscriber_cap
    column :subscriber_increment
    column :spouse_cap
    column :spouse_increment
    column :dependent_coverage
    column :dependent_rate
    
    actions dropdown: true do
      item "Return to Companies", admin_companies_path
    end
  end

# form
  form do |f|
    f.inputs "Life Benefit Details" do
	    #f.input :benefit_profile_id, as: :select, collection: BenefitProfile.where(company_id: BenefitProfile.find(resource.benefit_profile_id).company_id).map{|b| ["#{b.provider} #{b.provider_plan}", b.id]}
	    f.input :subscriber_cap, label: 'Cap for Subscriber Coverage'
	    f.input :subscriber_increment, label: 'Increment (by thousands)'
	    f.input :spouse_cap, label: 'Cap for Spouse Coverage'
	    f.input :spouse_increment, label: 'Increment (by thousands)'
	    f.input :dependent_coverage, label: 'Dependent Total Coverage Amount'
	    f.input :dependent_rate, label: 'Monthly renewal rate for dependents'
    end
    f.actions
  end
end
