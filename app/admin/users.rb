ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#

    controller do
      def update_resource(object, attributes)
        update_method = attributes.first[:password_confirmation].present? ? :update_attributes : :update_without_password
        object.send(update_method, *attributes)
      end
    end


    index do
        selectable_column
        id_column
        column "Confirmé", :confirmation_webmaster
        column :email
        column :created_at
        actions
    end
    batch_action :confirm do |ids|
        batch_action_collection.find(ids).each do |user|
            user.confirmation_webmaster = true
            user.save!
        end
        redirect_to collection_path, alert: "These users has been confirmed."
    end

    batch_action :destroy, false

    permit_params :login, :password, :password_confirmation, :email, :username, :confirmation_webmaster, :surname, :lastname, :afficher_email, :afficher_identite, :afficher_tel, :current_password
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
    form do |f|
        f.inputs do
            f.input :username
            f.input :email
            f.input :surname
            f.input :lastname
            f.input :afficher_identite
            f.input :afficher_email
            f.input :tel
            f.input :afficher_tel 
            f.input :paysresidence 
            f.input :villeresidence
            f.input :codepostal
            f.input :instagram 
            f.input :facebook
            f.input :website
            f.input :description
            f.input :masquefavoris
            f.input :statut
            f.input :masquepublication
            f.input :nbvue_profil
            f.input :confirmation_webmaster
            f.input :provider
            f.input :uid
            f.input :photoprofil
            f.input :photofond
        end
        f.actions
    end

end
