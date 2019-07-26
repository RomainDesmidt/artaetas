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
      params[:annonce][:categorie_ids].each do |id|
        categorie = Categorie.find(id)
        categoriea = CategorieAnnonce.new( categorie: categorie, annonce_id: @annonce.id )
        categoriea.save!
      end
      params[:annonce][:courant_ids].each do |id|
        courant = Courant.find(id)
        couranta = CourantAnnonce.new( courant: courant, annonce_id: @annonce.id )
        couranta.save!
      end
      params[:annonce][:couleur_ids].each do |id|
        couleur = Couleur.find(id)
        couleura = CouleurAnnonce.new( couleur: couleur, annonce_id: @annonce.id )
        couleura.save!
      end

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
    params.require(:annonce).permit(:name, :description, :photo, :photo_cache , :user_id, :prix, :format, :disposition, :hauteur, :largeur, :profondeur, :oeuvre_limite, :oeuvre_unique, :oeuvre_illimite, :facture_achat, :certificat_authenticite, :encadrement, :etat_neuf, :term, :categorie_ids =>   [], :courant_ids =>   [], :couleur_ids =>   [])
  end
end

# {photo: []}
