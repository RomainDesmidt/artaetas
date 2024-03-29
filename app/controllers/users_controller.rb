class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  def index
    @users = User.all
  end
  def show
    if current_user then
      Reporting.create!(userid: current_user.id, username: current_user.username, params: params, origin: "user show")  
    end       
    @username = params[:username]
    # @user= User.find(params[:id])
    @user= User.where(username: @username).first
    @bookmark = @user.bookmarkees_by(Annonce)
    # @bookmark = []
    @bmlist = []
    @bookmark.each do |bm|
      @bmlist << Annonce.find(bm.bookmarkee_id)
    end
  end
  def mesannonces
    @bookmark = current_user.bookmarkees_by(Annonce)
    @bmlist = []
    @bookmark.each do |bm|
      @bmlist << Annonce.find(bm.bookmarkee_id)
    end
    @annonces = current_user.annonces
  end
  
  def mesfavoris
    @bookmark = current_user.bookmarkees_by(Annonce)
    @bmlist = []
    @bookmark.each do |bm|
      @bmlist << Annonce.find(bm.bookmarkee_id)
    end
    @annonces = current_user.annonces
  end
  
  def mesinfos
    @bookmark = current_user.bookmarkees_by(Annonce)
    @bmlist = []
    @bookmark.each do |bm|
      @bmlist << bm.bookmarkee_id
    end
    @annonces = current_user.annonces
  end
  
  def mestransactions
    @orders = current_user.orders
    @gifted = @orders.where(state: "gifted")
    @pending = @orders.where(state: "pending")
    @paid = @orders.where(state: "paid")    
    @bookmark = current_user.bookmarkees_by(Annonce)
    @bmlist = []
    @bookmark.each do |bm|
      @bmlist << bm.bookmarkee_id
    end
    @annonces = current_user.annonces    
  end

  def me
    @orders = current_user.orders
    @gifted = @orders.where(state: "gifted")
    @pending = @orders.where(state: "pending")
    @paid = @orders.where(state: "paid")
    @bookmark = current_user.bookmarkees_by(Annonce)
    @bmlist = []
    @bookmark.each do |bm|
      @bmlist << Annonce.find(bm.bookmarkee_id)
    end
    @annonces = current_user.annonces
    unless current_user.compteur_rappel.nil?
      if current_user.tel.blank? || current_user.statut.blank? || current_user.surname.blank? || current_user.lastname.blank? || current_user.paysresidence.blank? || current_user.villeresidence.blank? || current_user.codepostal.blank?
        if current_user.compteur_rappel < 6
          flash.now[:notice] = 'Veuillez compléter les informations de votre profil'
        end
      end  
    end
    # flash.now[:notice] = 'Veuillez completer les informations de votre profil'
  end
end
