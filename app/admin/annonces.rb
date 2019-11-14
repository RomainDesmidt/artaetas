ActiveAdmin.register Annonce do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
    index do
        selectable_column
        id_column
        column "Publiée", :envente_yesno
        column :name
        column :user
        column :created_at
        actions
    end


permit_params   :user_id_artiste, :envente_yesno, :name, :anneecreation, :nom_artiste, :description, :photo, 
                :photo_cache, :photo_un, :photo_un_cache, :photo_deux, :photo_deux_cache,  :user_id, :prix, :format,
                :disposition, :hauteur, :largeur, :profondeur, :oeuvre_limite, :oeuvre_unique, :oeuvre_illimite, :facture_achat, 
                :certificat_authenticite, :encadrement, :etat_neuf, :term, :categorie_search, :courant_search, :couleur_search, :prix_slider,
                { categorie_annonces: [:id] },
                { courant_annonces: [:id] },
                { couleur_annonces: [:id] },
                { categorie_search2: [:id] },
                { courant_search2: [:id] },
                { couleur_search2: [:id] },
                { categorie_ids: [:id] }, 
                { courant_ids: [:id] },
                { couleur_ids: [:id] },
                { cat_ids: [:id] }
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
