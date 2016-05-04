ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation
  menu priority: 3

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  # FILTER USER AS MANAGER OR EE
  #member_action :sign_as, method: :get do
  #  user = User.find(params[:id])
  #  sign_in user
  #  if user.role == 'manager'
  #    redirect_to manager_dashboard_path
  #  else
  #    redirect_to employee_dashboard_path
  #  end
  #end  

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
