ActiveAdmin.register Employee do
  menu priority: 5
  belongs_to :company

  # Edit fields to save
  permit_params :name, :first_name, :last_name, :company_id, :email, :address, 
                :city, :state, :zip, :phone_number, :sub_id, :user_id, :date_of_birth,
                :benefit_eligible, :view_salary, :employee_category
  
  index do
    selectable_column
    column :company_id
    column :user_id
    id_column
    # make EE list reflect showing name of Company here
    column :last_name
    column :first_name
    column :benefit_eligible
    column :employee_category
    column :view_salary
    column :sub_id
    column :email
    column :date_of_birth
    column :created_at
    actions dropdown: true do |employee|
      item "Benefit Profiles", admin_company_benefit_profiles_path(employee)
      item "Dependents", admin_employee_dependents_path(employee)
      item "Return to Companies", admin_companies_path      
    end
  end

  filter :first_name
  filter :last_name
  filter :sub_id
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Employee Details" do
      f.input :first_name, label: 'First Name', :placeholder => "First Name"
      f.input :last_name, label: 'Last Name', :placeholder => "Last Name"
      f.input :company_id, as: :select, collection: Company.all.map{|c| ["#{c.name}", c.id]}
      # EE must also be a current user
      f.input :user_id, as: :select, collection: User.all.map{|u| ["#{u.email}", u.id]}.sort
      f.input :email
      f.input :sub_id, label: "Sub ID", :placeholder => "Subscriber ID"
      f.input :address, :placeholder => "Street Address"
      f.input :city, :placeholder => "City"
      f.input :state, as: :select, :collection => States::ABBREVIATIONS
      f.input :zip, :placeholder => "Zip"
      f.input :phone_number, :placeholder => "Phone"
      f.input :date_of_birth, :start_year => 1950, :end_year => 2005
      f.input :benefit_eligible
      f.input :employee_category, as: :select, :collection => [['Employee'], ['Manager'], ['Owner']]
      f.input :view_salary
    end
    f.actions
  end

  # Creating an Employee Adds a correlated User in Admin
  after_save do |employee|
    user = User.invite!({:email => employee.email})
    if employee.employee_category == "Manager"
      user.manager = true
    else employee.employee_category == "Employee"
      user.employee = true
    end
    user.save!
    employee.user_id = user.id
    employee.save
  end
end
