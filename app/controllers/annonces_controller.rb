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
      unless params[:annonce][:categorie_annonces].nil?
        params[:annonce][:categorie_annonces].each do |id|
          unless id==""
            categorie = Categorie.find(id)
            categoriea = CategorieAnnonce.new( categorie: categorie, annonce_id: @annonce.id )
            categoriea.save!
          end
        end
      end

      unless params[:annonce][:courant_ids].nil?
        params[:annonce][:courant_ids].each do |id|
          unless id==""
            courant = Courant.find(id)
            couranta = CourantAnnonce.new( courant: courant, annonce_id: @annonce.id )
            couranta.save!
          end
        end
      end

      unless params[:annonce][:couleur_ids].nil?
        params[:annonce][:couleur_ids].each do |id|
          unless id==""
            couleur = Couleur.find(id)
            couleura = CouleurAnnonce.new( couleur: couleur, annonce_id: @annonce.id )
            couleura.save!
          end
        end
      end

      redirect_to @annonce
      flash[:error] = "it worked"
    else
      render 'new'
    end
  end

  def search
    # @pricemin = params[:pricemin]
    # @pricemax = params[:pricemax]
    price_all = []
    Annonce.all.each do |u|
      price_all << u.prix.to_i
    end
    @slider_max = price_all.map(&:to_i).max + 1
    if @slider_max < 100
      @slider_max = 1000
    end
    
    
    # Params Get
    @categorie_search2 = params[:categorie_search2]
    @courant_search2 = params[:courant_search2]
    @couleur_search2 = params[:couleur_search2]
    unless params[:prix_slider].nil?
      @pricemin = params[:prix_slider].split(",",2)[0].to_i
      @pricemax = params[:prix_slider].split(",",2)[1].to_i
    end
    
    # List of id to use to filter search results
    @categorie_idarray = []
    @courant_idarray = []
    @couleur_idarray = []
    
    # Array to compare with params[]
    categories_annonceunitaire = []
    categories_choisies = []
    courants_annonceunitaire = []
    courants_choisis = []
    couleurs_annonceunitaire = []
    couleurs_choisies = []
    
    # Shown Annonces
    @annonces = Annonce.all
    unless params[:term] == "Que recherchez-vous?"
      if params[:term]
        @annonces = Annonce.where('name ILIKE ? OR description ILIKE ?', "%#{params[:term]}%", "%#{params[:term]}%")
      end
    end
    unless params[:prix_slider] == ''
      if params[:prix_slider]
        @annonces = @annonces.where("prix > ?", @pricemin)
      end
    end


    unless params[:prix_slider] == ''
      if params[:prix_slider]
        @annonces = @annonces.where("prix < ?", @pricemax)
      end
    end

    unless params[:categorie_search2] == ''
      if params[:categorie_search2]
        Annonce.all.each do |annonce_unitaire|
          categories_annonceunitaire = annonce_unitaire.categorie_annonces.collect {|u| u.categorie_id}
          params[:categorie_search2].each { |u| categories_choisies << u.to_i }
          if categories_choisies - categories_annonceunitaire == []
            @categorie_idarray << annonce_unitaire.id
          end
        end
        @annonces = @annonces.where(id: @categorie_idarray)
      end
    end

    unless params[:courant_search2] == ''
      if params[:courant_search2]
        Annonce.all.each do |annonce_unitaire|
          courants_annonceunitaire = annonce_unitaire.courant_ids
          params[:courant_search2].each { |u| courants_choisis << u.to_i }
          if courants_choisis - courants_annonceunitaire == []
            @courant_idarray << annonce_unitaire.id
          end
        end
        @annonces = @annonces.where(id: @courant_idarray)
      end
    end

    unless params[:couleur_search2] == ''
      if params[:couleur_search2]
        Annonce.all.each do |annonce_unitaire|
          couleurs_annonceunitaire = annonce_unitaire.couleur_ids
          params[:couleur_search2].each { |u| couleurs_choisies << u.to_i }
          if couleurs_choisies - couleurs_annonceunitaire == []
            @couleur_idarray << annonce_unitaire.id
          end
        end
        @annonces = @annonces.where(id: @couleur_idarray)
      end
    end


  end


  def show
    @annonces = Annonce.find(params[:id])
    @user = User.find(@annonces.user_id)
    if @annonces.hauteur.nil?
      @hauteur = 1
    else
      @hauteur = @annonces.hauteur
    end
    if @annonces.profondeur.nil?
      @profondeur = 1
    else
      @profondeur = @annonces.profondeur
    end
    if @annonces.largeur.nil?
      @largeur = 1
    else
      @largeur = @annonces.largeur
    end
    
    @volume = @largeur * @hauteur * @profondeur / 1000000
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
    # @annonce.update(annonce_params)

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

      unless params[:annonce][:categorie_annonces].nil?
      params[:annonce][:categorie_annonces].each do |id|
        unless @categoriesbdd.include?(id.to_i)
          unless id==""
            categorie = Categorie.find(id)
            categoriea = CategorieAnnonce.new( categorie: categorie, annonce_id: @annonce.id )
            categoriea.save!
          end
        end
      end
    end


    unless @categoriesbdd.nil?

      if params[:annonce][:categorie_annonces].nil?
        categoriedelall = CategorieAnnonce.where(annonce_id: @annonce.id)
        categoriedelall.each do |cat|
          cat.destroy
        end
      else
        @categoriesbdd.each do |id_db|
          unless params[:annonce][:categorie_annonces].include?(id_db.to_s)
            categoriedel = CategorieAnnonce.where(annonce_id: @annonce.id).where(categorie_id: id_db)
            categoriedel.each do |cat|
              cat.destroy
            end
          end
        end
      end
    end

    # unless params[:annonce][:courant_ids].nil?
    #   params[:annonce][:courant_ids].each do |id|
    #     unless @courantsbdd.include?(id)
    #       unless id==""
    #         courant = Courant.find(id)
    #         couranta = CourantAnnonce.new( courant: courant, annonce_id: @annonce.id )
    #         couranta.save!
    #       end
    #     end
    #   end
    # end


    # unless @courantsbdd.nil?

    #   if params[:annonce][:courant_ids].nil?
    #     courantdelall = CourantAnnonce.where(annonce_id: @annonce.id)
    #     courantdelall.each do |cour|
    #       cour.destroy
    #     end
    #   else
    #     @courantsbdd.each do |id_db|
    #       unless params[:annonce][:courant_ids].include?(id_db)
    #         courantdel = CourantAnnonce.where(annonce_id: @annonce.id).where(courant_id: id_db)
    #         courantdel.each do |cour|
    #           cour.destroy
    #         end
    #       end
    #     end
    #   end
    # end

    # unless params[:annonce][:couleur_ids].nil?
    #   params[:annonce][:couleur_ids].each do |id|
    #     unless @couleursbdd.include?(id)
    #       unless id==""
    #         couleur = Couleur.find(id)
    #         couleura = CouleurAnnonce.new( couleur: couleur, annonce_id: @annonce.id )
    #         couleura.save!
    #       end
          
    #     end
    #   end
    # end


    # unless @couleursbdd.nil?

    #   if params[:annonce][:couleur_ids].nil?
    #     couleurdelall = CouleurAnnonce.where(annonce_id: @annonce.id)
    #     couleurdelall.each do |coul|
    #       coul.destroy
    #     end
    #   else
    #     @couleursbdd.each do |id_db|
    #       unless params[:annonce][:couleur_ids].include?(id_db)
    #         couleurdel = CouleurAnnonce.where(annonce_id: @annonce.id).where(couleur_id: id_db)
    #         couleurdel.each do |coul|
    #           coul.destroy
    #         end
    #       end
    #     end
    #   end
    # end
    
    
    @annonce.update(annonce_params)
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

    unless CategorieAnnonce.all.where(annonce_id: @annonce.id).nil?
      CategorieAnnonce.all.where(annonce_id: @annonce.id).destroy_all
     end
     unless CourantAnnonce.all.where(annonce_id: @annonce.id).nil?
       CourantAnnonce.all.where(annonce_id: @annonce.id).destroy_all
     end
     unless CouleurAnnonce.all.where(annonce_id: @annonce.id).nil?
       CouleurAnnonce.all.where(annonce_id: @annonce.id).destroy_all
     end
    @annonce.destroy
  redirect_to '/users/me'
  end


  
  def bookmark
    @annonce = Annonce.find(params[:id])
    current_user.bookmark(@annonce)
    redirect_to @annonce
  end
  
  def unbookmark
    @annonce = Annonce.find(params[:id])
    current_user.unbookmark(@annonce)
    redirect_to @annonce
  end
  
  
  def like
    @annonce = Annonce.find(params[:id])
    @annonce.liked_by current_user
    redirect_to @annonce
  end

  def likeuser
    @annonce = Annonce.find(params[:id])
    @user = User.find(@annonce.user_id)
    @user.liked_by current_user
    redirect_to @annonce
  end

  def dislike   
    @annonce = Annonce.find(params[:id])
    @annonce.disliked_by current_user
    redirect_to @annonce
  end

  def dislikeuser
    @annonce = Annonce.find(params[:id])
    @user = User.find(@annonce.user_id)
    @user.disliked_by current_user
    redirect_to @annonce
  end

  def follow
    @annonce = Annonce.find(params[:id])
    @user = User.find(@annonce.user_id)
    @user.followers << current_user
    redirect_to @annonce
  end

  def unfollow
    @annonce = Annonce.find(params[:id])
    @user = User.find(@annonce.user_id)
    Follow.where(follower_id: current_user.id, followee_id: @user.id).first.destroy!
    redirect_to @annonce
  end

  private

  def annonce_params
    params.require(:annonce).permit(:name, :anneecreation, :nom_artiste, :description, :photo, :photo_cache, :photo_un, :photo_un_cache, :photo_deux, :photo_deux_cache,  :user_id, :prix, :format, :disposition, :hauteur, :largeur, :profondeur, :oeuvre_limite, :oeuvre_unique, :oeuvre_illimite, :facture_achat, :certificat_authenticite, :encadrement, :etat_neuf, :term, :categorie_search, :courant_search, :couleur_search, :prix_slider,  :categorie_search2 => [], :courant_search2 => [], :couleur_search2 => [], :categorie_ids => [], :courant_ids => [], :couleur_ids => [], :cat_ids => [])
  end
end

# {photo: []}
