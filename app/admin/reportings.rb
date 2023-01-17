ActiveAdmin.register Reporting do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :username, :userid, :params, :origin
  #
  # or
  #
  # permit_params do
  #   permitted = [:username, :userid, :params, :origin]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
