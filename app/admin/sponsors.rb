ActiveAdmin.register Sponsor do
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

#menu :parent => "Adverts", :if => proc { false }
menu :parent => "Aceurs" , :if => proc { false }

permit_params :name, :lien_image, :lien_redir, :lien_video, :texte, :publiee, :period_start, :compteur

end
