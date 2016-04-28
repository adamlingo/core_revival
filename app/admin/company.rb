ActiveAdmin.register Company do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
permit_params :name, :email, :processor_name, :address, :city, :state, :zip, :phone_number, :federal_id_number,
                      :state_wh_number, :unemployment_number

  index do
    # Admin columns to show for Company
    selectable_column
    # id_column
    column :name
    column :email
    column :processor_name
    column :address
    column :city
    column :state
    column :zip
    column :phone_number
    actions
  end

  # Search filters
  filter :name
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Company Details" do
      f.input :name, label: 'Company Name', :placeholder => "Company Name"
      f.input :email, as: :email, :placeholder => "Email"
      f.input :processor_name, label: 'Processor Name', :placeholder => "Processor Name"
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
      f.input :federal_id_number, :placeholder => "Federal ID number"
      f.input :state_wh_number, :placeholder => "State Withholding number"
      f.input :unemployment_number, :placeholder => "Unemployment number"
    end
    f.actions
  end

end
