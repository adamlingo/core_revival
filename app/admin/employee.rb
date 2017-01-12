ActiveAdmin.register Employee do
  # permit_params :email, :password, :password_confirmation
  # ^^ save defaults just in case
  menu priority: 5
  belongs_to :company

  # Edit fields to save
  permit_params :name, :first_name, :last_name, :company_id, :email, :address, 
                :city, :state, :zip, :phone_number, :sub_id, :user_id
  
  index do
    selectable_column
    column :company_id
    column :user_id
    id_column
    # make EE list reflect showing name of Company here
    column :last_name
    column :first_name
    column :sub_id
    column :email
    column :created_at
    actions dropdown: true do |employee|
      item "Benefit Profiles", admin_company_benefit_profiles_path(employee)
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
      # EE must be attached to an existent Company, UNMAP FROM ALL TO CURRENT!!
      f.input :company_id, as: :select, collection: Company.all.map{|c| ["#{c.name}", c.id]}
      # EE must also be a current user
      f.input :user_id, as: :select, collection: User.all.map{|u| ["#{u.email}", u.id]}.sort
      f.input :email
      f.input :sub_id, label: "Sub ID", :placeholder => "Subscriber ID"
      # f.input :password
      # f.input :password_confirmation
      f.input :address, :placeholder => "Street Address"
      f.input :city, :placeholder => "City"
      f.input :state, as: :select, :collection => States::ABBREVIATIONS
      f.input :zip, :placeholder => "Zip"
      f.input :phone_number, :placeholder => "Phone"
    end
    f.actions
  end

end
