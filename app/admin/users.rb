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
    column "Approuvé?", :confirmation_webmaster
    column :email
    column :username
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
  permit_params :login, :password, :password_confirmation, :email, :username, :confirmation_webmaster, :surname, :lastname, :afficher_email, :afficher_identite, :afficher_tel, :current_password, :instagram, :facebook, :website, :codepostal, :paysresidence
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end


  action_item :previous, only: [:show, :edit] do
    id = User.where('id < ?', params[:id]).order('id DESC').first
    if id.nil?
      link_to 'Previous', admin_user_path(id: params[:id])
    else
      link_to 'Previous', admin_user_path(id: id)
    end
  end

  action_item :next, only: [:show, :edit] do
    id = User.where('id > ?', params[:id]).order('id ASC').first
    if id.nil?
      link_to 'Next', admin_user_path(id: params[:id])
    else
      link_to 'Next', admin_user_path(id: id)
    end
  end
  
  action_item :valider, only: [:show], if: proc { User.find(params[:id]).confirmation_webmaster == true }  do 
    link_to 'Censurer', depublier_admin_user_path, method: :put
  end
  
  action_item :invalider, only: [:show], if: proc { User.find(params[:id]).confirmation_webmaster == false }  do 
    link_to 'Approuver', publier_admin_user_path, method: :put
  end
  
  action_item :invalidernil, only: [:show], if: proc { User.find(params[:id]).confirmation_webmaster == nil }  do 
    link_to 'Approuver', publier_admin_user_path, method: :put
  end
  
  action_item :validernil, only: [:show], if: proc { User.find(params[:id]).confirmation_webmaster == nil }  do 
    link_to 'Censurer', depublier_admin_user_path, method: :put
  end
  
  action_item :deconfirm, only: [:show], if: proc { User.find(params[:id]).confirmed? && User.find(params[:id]).confirmation_webmaster == false }  do 
    link_to 'Bloquer', bloquer_admin_user_path, method: :put
  end
  
  action_item :reconfirm, only: [:show], if: proc { User.find(params[:id]).confirmed_at == nil }  do 
    link_to 'Débloquer', debloquer_admin_user_path, method: :put
  end
  
  action_item :onpartner, only: [:show], if: proc { User.find(params[:id]).partner == false || User.find(params[:id]).partner == nil  }  do 
    link_to 'Partenaire', partneron_admin_user_path, method: :put
  end
  
  action_item :offpartner, only: [:show], if: proc { User.find(params[:id]).partner == true }  do 
    link_to 'NonPartenaire', partneroff_admin_user_path, method: :put
  end
  
  action_item :userreport, only: [:show]  do 
    #admin_welcome_messages_path(edit: true), :method => :get
    link_to 'UserStats', reportindiv_admin_user_path, method: :get
    #link_to 'UserStats', admin_stats_path
  end
  
  member_action :partneron, :method => :put do
    @modif_user = User.find(params[:id])
    @modif_user.update(partner: true)
    #AdminMailer.with(user: @modif_user ).refuse_user.deliver_now
    redirect_to admin_user_path
  end
  
  member_action :partneroff, :method => :put do
    @modif_user = User.find(params[:id])
    @modif_user.update(partner: false)
    #AdminMailer.with(user: @modif_user ).refuse_user.deliver_now
    redirect_to admin_user_path
  end
  
  member_action :publier, :method => :put do
    @modif_user = User.find(params[:id])
    @modif_user.confirmation_webmaster = true
    @modif_user.save!
    #AdminMailer.with(user: @modif_user ).confirm_user.deliver_now
    redirect_to admin_user_path
  end
  
  member_action :depublier, :method => :put do
    @modif_user = User.find(params[:id])
    @modif_user.confirmation_webmaster = false
    @modif_user.save!
    #AdminMailer.with(user: @modif_user ).refuse_user.deliver_now
    redirect_to admin_user_path
  end
  
  member_action :bloquer, :method => :put do
    @modif_user = User.find(params[:id])
    @modif_user.update(confirmed_at: nil)
    #AdminMailer.with(user: @modif_user ).refuse_user.deliver_now
    redirect_to admin_user_path
  end
  
  member_action :debloquer, :method => :put do
    @modif_user = User.find(params[:id])
    @modif_user.update(confirmed_at: Time.now)
    #AdminMailer.with(user: @modif_user ).refuse_user.deliver_now
    redirect_to admin_user_path
  end
  
  member_action :reportindiv, method: :get do
    #render active_admin_template('_reportindiv.html.erb'), :layout => false
    render partial: 'reportindiv'
    
  end
  


  # action_item :valider, only: [:show, :edit] do
  #   if User.find(params[:id]).confirmation_webmaster
  #     link_to 'Suspendre'
  #     modif_user = User.find(params[:id])
  #     modif_user.confirmation_webmaster = false
  #     modif_user.save!
  #   else
  #     link_to 'Confirmer'
  #     modif_user = User.find(params[:id])
  #     modif_user.confirmation_webmaster = true
  #     modif_user.save!
  #   end
  # end


  form do |f|
    f.inputs do
            f.input :username
            f.input :email
            #f.input :current_password ## a delete
            #f.input :password ## a delete
            #f.input :password_confirmation ## a delete
            f.input :surname
            f.input :lastname
            f.input :partner
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
