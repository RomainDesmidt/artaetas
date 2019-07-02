class AnnoncesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @annonces = Annonce.all
  end

  def new
    @annonce = current_user.annonces.new
  end

  def create
    @annonce = current_user.annonces.new(annonce_params)
    @annonce_params = annonce_params
    if  @annonce.save
      redirect_to @annonce
      flash[:error] = "it worked"
    else
      render 'new'
    end
  end

  def search
    @annonces = Annonce.where(name: 'Garboulet')
  end


  def show
    @annonces = Annonce.find(params[:id])
  end

  def edit
    @annonce = Annonce.find(params[:id])
  end

  def update
    @annonce = Annonce.find(params[:id])
    @annonce.update(annonce_params) # We'll see that in a moment.
    redirect_to @annonce
  end

  private

  def annonce_params
    params.require(:annonce).permit(:name, :description, :photo, :photo_cache , :user_id, :prix, :format, :disposition, :hauteur, :largeur, :profondeur, :oeuvre_limite, :oeuvre_unique, :oeuvre_illimite, :facture_achat, :certificat_authenticite, :encadrement, :etat_neuf)
  end
end

# {photo: []}
