ActiveAdmin.register Employee do
  # permit_params :email, :password, :password_confirmation
  # ^^ save defaults just in case

  menu parent: "Companies"

  # Edit fields to save
  permit_params :name, :company_id, :email, :address, :city, :state, :zip, :phone_number
  
  index do
    selectable_column
    column :company_id
    id_column
    # make EE list reflect showing name of Company here
    column :name
    column :email
    column :created_at
    actions
  end

  filter :company
  filter :name
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Employee Details" do
      f.input :name, label: 'Employee Name', :placeholder => "Employee Name"
      # EE must be attached to an existent Company
      f.input :company_id, as: :select, collection: Company.all.map{|c| ["#{c.name}", c.id]}
      # EE must also be a current user
      # f.input :user_id, as: :select, collection: User.all.map{|u| ["#{u.last_name} , #{u.first_name}", u.id]}
      f.input :email
      # f.input :password
      # f.input :password_confirmation
      f.input :address, :placeholder => "Street Address"
      f.input :city, :placeholder => "City"
      f.input :state, as: :select, :collection => [
                                            ['AL', 'AL'],
                                            ['AK', 'AK'],
                                            ['AZ', 'AZ'],
                                            ['AR', 'AR'],
                                            ['CA', 'CA'],
                                            ['CO', 'CO'],
                                            ['CT', 'CT'],
                                            ['DE', 'DE'],
                                            ['DC', 'DC'],
                                            ['FL', 'FL'],
                                            ['GA', 'GA'],
                                            ['HI', 'HI'],
                                            ['ID', 'ID'],
                                            ['IL', 'IL'],
                                            ['IN', 'IN'],
                                            ['IA', 'IA'],
                                            ['KS', 'KS'],
                                            ['KY', 'KY'],
                                            ['LA', 'LA'],
                                            ['ME', 'ME'],
                                            ['MD', 'MD'],
                                            ['MA', 'MA'],
                                            ['MI', 'MI'],
                                            ['MN', 'MN'],
                                            ['MS', 'MS'],
                                            ['MO', 'MO'],
                                            ['MT', 'MT'],
                                            ['NE', 'NE'],
                                            ['NV', 'NV'],
                                            ['NH', 'NH'],
                                            ['NJ', 'NJ'],
                                            ['NM', 'NM'],
                                            ['NY', 'NY'],
                                            ['NC', 'NC'],
                                            ['ND', 'ND'],
                                            ['OH', 'OH'],
                                            ['OK', 'OK'],
                                            ['OR', 'OR'],
                                            ['PA', 'PA'],
                                            ['PR', 'PR'],
                                            ['RI', 'RI'],
                                            ['SC', 'SC'],
                                            ['SD', 'SD'],
                                            ['TN', 'TN'],
                                            ['TX', 'TX'],
                                            ['UT', 'UT'],
                                            ['VT', 'VT'],
                                            ['VA', 'VA'],
                                            ['WA', 'WA'],
                                            ['WV', 'WV'],
                                            ['WI', 'WI'],
                                            ['WY', 'WY']
                                          ]
      f.input :zip, :placeholder => "Zip"
      f.input :phone_number, :placeholder => "Phone"
    end
    f.actions
  end

end
