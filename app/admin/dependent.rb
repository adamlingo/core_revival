ActiveAdmin.register Dependent do
	belongs_to :employee

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
	permit_params :employee_id, :relationship, :date_of_birth, :first_name, :last_name
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
	
	index do
		selectable_column
		column :employee_id
		column :last_name
		column :first_name
	end

	form do |f|
	  f.inputs "Dependent Details" do
	    f.input :first_name, label: 'First Name', :placeholder => "First Name"
	    f.input :last_name, label: 'Last Name', :placeholder => "Last Name"
	    f.input :relationship, label: 'Relationship', :placeholder => "Relationship"
	    # leave end year as current to handle dependents that are newborns, etc.
	    f.input :date_of_birth, :start_year => 1950, :end_year => Time.current.year
	  end
	  f.actions
	end
end