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
    
  show do
    attributes_table do
      row :envente_yesno
      row "Photo 1" do |image|
        image_tag image.photo.url, style: "width: 50px; height: 50px; object-fit: cover;", onMouseOver: "$(this).css({'width':'600px','height':'auto'})", onMouseOut: "$(this).css({'width':'50px','height':'50px'})"
      end
      if Annonce.find(params[:id]).photo_un?
        row "Photo 2" do |image|
          image_tag image.photo_un.url, style: "width: 50px; height: 50px; object-fit: cover;", onMouseOver: "$(this).css({'width':'600px','height':'auto'})", onMouseOut: "$(this).css({'width':'50px','height':'50px'})"
        end
      end
      if Annonce.find(params[:id]).photo_deux?
        row "Photo 3" do |image|
          image_tag image.photo_deux.url, style: "width: 50px; height: 50px; object-fit: cover;", onMouseOver: "$(this).css({'width':'600px','height':'auto'})", onMouseOut: "$(this).css({'width':'50px','height':'50px'})"
        end
      end
      row :name
      row :description
      row :prix
    end
    default_main_content do
      row :cats
      row :courants
      row :couleurs
    end
  end
    

  batch_action :confirm do |ids|
    batch_action_collection.find(ids).each do |annonce|
      annonce.envente_yesno = true
      annonce.save!
    end
    redirect_to collection_path, alert: "These annonces has been confirmed."
  end

  batch_action :destroy, false
    
  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs
    f.inputs "Tags" do         # builds an input field for every attribute
      f.input :cats
      f.input :courants
    # f.input :couleur_ids, :as => :select, :collection => Couleur.all.collect {|u| [u.couleur_dominante, u.id]}
      f.input :couleurs
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end

  action_item :valider, only: [:show], if: proc { Annonce.find(params[:id]).envente_yesno == true }  do 
    link_to 'Dépublier', depublier_admin_annonce_path, method: :put
  end
  
  action_item :invalider, only: [:show], if: proc { Annonce.find(params[:id]).envente_yesno == false }  do 
    link_to 'Publier', publier_admin_annonce_path, method: :put
  end
  
  action_item :invalidernil, only: [:show], if: proc { Annonce.find(params[:id]).envente_yesno == nil }  do 
    link_to 'Publier', publier_admin_annonce_path, method: :put
  end
  
  action_item :validernil, only: [:show], if: proc { Annonce.find(params[:id]).envente_yesno == nil }  do 
    link_to 'Dépublier', depublier_admin_annonce_path, method: :put
  end
  
  member_action :publier, :method => :put do
    modif_annonce = Annonce.find(params[:id])
    modif_annonce.envente_yesno = true
    modif_annonce.save!
    @modif_usertarget = modif_annonce.user
    AdminMailer.with(user: @modif_usertarget).confirm_user_annonce.deliver_now
    redirect_to admin_annonce_path
  end
  
  member_action :depublier, :method => :put do
    modif_annonce = Annonce.find(params[:id])
    modif_annonce.envente_yesno = false
    modif_annonce.save!
    @modif_usertarget = modif_annonce.user
    AdminMailer.with(user: @modif_usertarget).refuse_user_annonce.deliver_now
    redirect_to admin_annonce_path
  end

  action_item :previous, only: [:show, :edit] do
    id = Annonce.where('id < ?', params[:id]).order('id DESC').first
    if id.nil?
      link_to 'Previous', admin_annonce_path(id: params[:id])
    else
      link_to 'Previous', admin_annonce_path(id: id)
    end
  end

  action_item :next, only: [:show, :edit] do
    id = Annonce.where('id > ?', params[:id]).order('id ASC').first
    if id.nil?
      link_to 'Next', admin_annonce_path(id: params[:id])
    else
      link_to 'Next', admin_annonce_path(id: id)
    end
  end



  permit_params   :user_id_artiste, :envente_yesno, :name, :anneecreation, :nom_artiste, :description, :photo, :photo_cache, :photo_un, :photo_un_cache, :photo_deux, :photo_deux_cache,  :user_id, :prix, :format, :disposition, :hauteur, :largeur, :profondeur, :oeuvre_limite, :oeuvre_unique, :oeuvre_illimite, :facture_achat,  :certificat_authenticite, :encadrement, :etat_neuf, :term, :categorie_search, :courant_search, :couleur_search, :prix_slider, categorie_annonces: [], courant_annonces: [], couleur_annonces: [] , categorie_search2: [], courant_search2: [], couleur_search2: [] , categorie_ids: [] , courant_ids: [] , couleur_ids: [], cat_ids: []
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
