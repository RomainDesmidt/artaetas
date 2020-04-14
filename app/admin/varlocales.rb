ActiveAdmin.register Varlocale do
    actions :index, :edit, :update
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#

  index do
    id_column
    column :nomchamp
    column :valeurchamp
    column :description
    actions
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs "Tags" do  
        f.input :nomchamp, input_html: { disabled: true } 
        f.input :valeurchamp
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end



permit_params :valeurchamp
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
