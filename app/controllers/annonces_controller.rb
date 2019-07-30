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
    @categories = []
    @couleurs = []
    @courants = []
    CategorieAnnonce.where(annonce_id: @annonce.id).each do |a|
      @categories << a.categorie_id
    end
    CourantAnnonce.where(annonce_id: @annonce.id).each do |a|
      @courants << a.courant_id
    end
    CouleurAnnonce.where(annonce_id: @annonce.id).each do |a|
      @couleurs << a.couleur_id
    end
  end

  def update
    @annonce = Annonce.find(params[:id])
    @annonce.update(annonce_params)

    @categoriesbdd = []
    @couleursbdd = []
    @courantsbdd = []

    CategorieAnnonce.where(annonce_id: @annonce.id).each do |a|
      @categoriesbdd << a.categorie_id
    end
    CourantAnnonce.where(annonce_id: @annonce.id).each do |a|
      @courantsbdd << a.courant_id
    end
    CouleurAnnonce.where(annonce_id: @annonce.id).each do |a|
      @couleursbdd << a.couleur_id
    end

    unless params[:annonce][:categorie_ids].nil?
      params[:annonce][:categorie_ids].each do |id|
        unless @categoriesbdd.include?(id.to_i)
          categorie = Categorie.find(id)
          categoriea = CategorieAnnonce.new( categorie: categorie, annonce_id: @annonce.id )
          categoriea.save!
        end
      end
    end


    unless @categoriesbdd.nil?

      if params[:annonce][:categorie_ids].nil?
        categoriedelall = CategorieAnnonce.where(annonce_id: @annonce.id)
        categoriedelall.each do |cat|
          cat.destroy
        end
      else
        @categoriesbdd.each do |id_db|
          unless params[:annonce][:categorie_ids].include?(id_db.to_s)
            categoriedel = CategorieAnnonce.where(annonce_id: @annonce.id).where(categorie_id: id_db)
            categoriedel.each do |cat|
              cat.destroy
            end
          end
        end
      end
    end

    unless params[:annonce][:courant_ids].nil?
      params[:annonce][:courant_ids].each do |id|
        unless @courantsbdd.include?(id)
          courant = Courant.find(id)
          couranta = CourantAnnonce.new( courant: courant, annonce_id: @annonce.id )
          couranta.save!
        end
      end
    end


    unless @courantsbdd.nil?

      if params[:annonce][:courant_ids].nil?
        courantdelall = CourantAnnonce.where(annonce_id: @annonce.id)
        courantdelall.each do |cour|
          cour.destroy
        end
      else
        @courantsbdd.each do |id_db|
          unless params[:annonce][:courant_ids].include?(id_db)
            courantdel = CourantAnnonce.where(annonce_id: @annonce.id).where(courant_id: id_db)
            courantdel.each do |cour|
              cour.destroy
            end
          end
        end
      end
    end

    unless params[:annonce][:couleur_ids].nil?
      params[:annonce][:couleur_ids].each do |id|
        unless @couleursbdd.include?(id)
          couleur = Couleur.find(id)
          couleura = CouleurAnnonce.new( couleur: couleur, annonce_id: @annonce.id )
          couleura.save!
        end
      end
    end


    unless @couleursbdd.nil?

      if params[:annonce][:couleur_ids].nil?
        couleurdelall = CouleurAnnonce.where(annonce_id: @annonce.id)
        couleurdelall.each do |coul|
          coul.destroy
        end
      else
        @couleursbdd.each do |id_db|
          unless params[:annonce][:couleur_ids].include?(id_db)
            couleurdel = CouleurAnnonce.where(annonce_id: @annonce.id).where(couleur_id: id_db)
            couleurdel.each do |coul|
              coul.destroy
            end
          end
        end
      end
    end

    # need to destroy CategorieAnnonce, CourantAnnonce, CouleurAnnonce unchecked
    # need to create new

      # params[:annonce][:categorie_ids].each do |id|
      #   categorie = Categorie.find(id)
      #   categoriea = CategorieAnnonce.new( categorie: categorie, annonce_id: @annonce.id )
      #   categoriea.save!
      # end
      # params[:annonce][:courant_ids].each do |id|
      #   courant = Courant.find(id)
      #   couranta = CourantAnnonce.new( courant: courant, annonce_id: @annonce.id )
      #   couranta.save!
      # end
      # params[:annonce][:couleur_ids].each do |id|
      #   couleur = Couleur.find(id)
      #   couleura = CouleurAnnonce.new( couleur: couleur, annonce_id: @annonce.id )
      #   couleura.save!
      # end
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
