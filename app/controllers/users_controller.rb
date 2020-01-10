class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def show
    @user= User.find(params[:id])
    @bookmark = @user.bookmarkees_by(Annonce)
    @bmlist = []
    @bookmark.each do |bm|
    @bmlist << bm.bookmarkee_id
    end
  end

  def me
    @annonces = current_user.annonces
    unless current_user.compteur_rappel.nil?
      if current_user.compteur_rappel < 6
        flash.now[:notice] = 'Veuillez completer les informations de votre profil'
      end
    end
    # flash.now[:notice] = 'Veuillez completer les informations de votre profil'
  end
end
