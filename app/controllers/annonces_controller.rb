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
    @pricemin = params[:pricemin]
    @pricemax = params[:pricemax]
    @annonces = Annonce.all
    unless params[:term] == "Que recherchez-vous?"
      if params[:term]
        @annonces = Annonce.where('name ILIKE ? OR description ILIKE ?', "%#{params[:term]}%", "%#{params[:term]}%")
      end
    end
    unless params[:pricemin] == ''
      if params[:pricemin]
        @annonces = @annonces.where("prix > ?", params[:pricemin])
      end
    end


    unless params[:pricemax] == ''
      if params[:pricemax]
        @annonces = @annonces.where("prix < ?", params[:pricemax])
      end
    end
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

  def destroy
    @annonce = Annonce.find(params[:id])
    @annonce.destroy
  redirect_to '/users/me'
  end

  private

  def annonce_params
    params.require(:annonce).permit(:name, :description, :photo, :photo_cache , :user_id, :prix, :format, :disposition, :hauteur, :largeur, :profondeur, :oeuvre_limite, :oeuvre_unique, :oeuvre_illimite, :facture_achat, :certificat_authenticite, :encadrement, :etat_neuf, :term)
  end
end

# {photo: []}
