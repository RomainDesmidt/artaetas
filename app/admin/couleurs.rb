ActiveAdmin.register Couleur do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
    menu :parent => "Coul", :if => proc { false }
    index do
        selectable_column
        id_column
        column :name
        column :created_at
        actions
    end


permit_params :name, :description, :couleur_dominante
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
