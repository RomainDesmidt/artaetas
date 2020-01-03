class AnnoncesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def destroy_photo_un
    @annonce = Annonce.find(params[:id])
    @annonce.remove_photo_un!
    @annonce.save!
  end

  def destroy_photo_deux
    @annonce = Annonce.find(params[:id])
    @annonce.remove_photo_deux!
    @annonce.save!
  end

  
  def index
    @annonces_confirmeduser = Annonce.joins(:user).where("users.confirmation_webmaster = true")
    @annonces_all = @annonces_confirmeduser.where(envente_yesno: true)
    @landingp = 1
    @annonces_premium = @annonces_all.where(formule: "Mise a la une").order('random()')
    @annonces_standard = @annonces_all.where(formule: "Standard").or(@annonces_all.where(formule: "Mise en Avant")).order('random()')
    @annonces = @annonces_standard.to_a
    @annonces_pre = @annonces_premium.to_a
    
  end
  
  def index2
    @annonces = Annonce.all
    @landingp = 1
  end

  def new
    @annonce = current_user.annonces.new
  end

  def create
    @annonce = current_user.annonces.new(annonce_params)
    @annonce_params = annonce_params
    unless  @annonce.largeur.nil? || @annonce.profondeur.nil? || @annonce.hauteur.nil?
      if @annonce.largeur > 0 && @annonce.profondeur > 0 && @annonce.hauteur > 0
        @volume = @annonce.largeur * @annonce.profondeur * @annonce.hauteur
        if @volume > 0.25
          if @volume > 1
            @annonce.update(volume: "g")
          else
            @annonce.update(volume: "m")
          end
        else
          @annonce.update(volume: "p")
        end
      end
    end
    
    if  @annonce.save
      # unless params[:annonce][:categorie_annonces].nil?
      #   params[:annonce][:categorie_annonces].each do |id|
      #     unless id==""
      #       categorie = Categorie.find(id)
      #       categoriea = CategorieAnnonce.new( categorie: categorie, annonce_id: @annonce.id )
      #       categoriea.save!
      #     end
      #   end
      # end

      # unless params[:annonce][:courant_ids].nil?
      #   params[:annonce][:courant_ids].each do |id|
      #     unless id==""
      #       courant = Courant.find(id)
      #       couranta = CourantAnnonce.new( courant: courant, annonce_id: @annonce.id )
      #       couranta.save!
      #     end
      #   end
      # end

      # unless params[:annonce][:couleur_ids].nil?
      #   params[:annonce][:couleur_ids].each do |id|
      #     unless id==""
      #       couleur = Couleur.find(id)
      #       couleura = CouleurAnnonce.new( couleur: couleur, annonce_id: @annonce.id )
      #       couleura.save!
      #     end
      #   end
      # end

      redirect_to @annonce, flash: { success: "L'annonce est en attente de modération, et est consultable dans l'onglet annonce du compte membre" }
      # flash[:error] = "it worked"
    else
      render 'new'
      flash[:error] = "Erreur a la creation"
    end
  end

  def search
    # @pricemin = params[:pricemin]
    # @pricemax = params[:pricemax]
    price_all = []
    Annonce.joins(:user).where("users.confirmation_webmaster = true").where(envente_yesno: true).each do |u|
      price_all << u.prix.to_i
    end
    
    if price_all.nil?
      price_all = 1
    else
      @slider_max = price_all.map(&:to_i).max + 1
    end
    
    if @slider_max < 100
      @slider_max = 1000
    end
    
    
    # Params Get
    @categorie_search2 = params[:categorie_search2]
    @courant_search2 = params[:courant_search2]
    @couleur_search2 = params[:couleur_search2]
    @administratif_search2 = params[:administratif_search2]
    @disposition_search2 = params[:disposition_search2]
    @code_postal_search2 = params[:code_postal_search2]
    @pays_search2 = params[:pays_search2]
    @volume_search2 = params[:volume_search2]
    
    @disposition = params[:disposition]
    @facture_achat = params[:facture_achat]
    @ordre_annonce = params[:ordre_annonce]
    @code_postal = params[:code_postal]
    @pays = params[:pays]
    @volume = params[:volume]
    # @code_postal_all = User.all.collect { |x| x.codepostal.divmod(1000)[0]}
    @code_postal_all = User.all.collect do |x| 
      unless x.codepostal.nil?
        x.codepostal.divmod(1000)[0]
      end
    end
    @code_postal_all = @code_postal_all.uniq
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
    
    # Restrict
    @annonces_all = Annonce.joins(:user).where("users.confirmation_webmaster = true").where(envente_yesno: true)
    # @annonces_premium = @annonces_all.where(formule: "Mise en Avant").or(@annonces_all.where(formule: "Mise a la une")).order('random()')
    @annonces_premium = @annonces_all.where(formule: "Mise en Avant").or(@annonces_all.where(formule: "Mise a la une"))
    # @annonces_standard = @annonces_all.where(formule: "Standard").order('random()')
    @annonces_standard = @annonces_all.where(formule: "Standard")
    @annonces = @annonces_standard
    @annonces_pre = @annonces_premium

    
    # Shown Annonces

    unless params[:term] == "Que recherchez-vous?"
      if params[:term]
        @annonces = @annonces.where('annonces.name ILIKE ? OR annonces.description ILIKE ?', "%#{params[:term]}%", "%#{params[:term]}%")
        @annonces_pre = @annonces_pre.where('annonces.name ILIKE ? OR annonces.description ILIKE ?', "%#{params[:term]}%", "%#{params[:term]}%")
      end
    end
    unless params[:prix_slider] == ''
      if params[:prix_slider]
        @annonces = @annonces.where("prix > ?", @pricemin)
        @annonces_pre = @annonces_pre.where("prix > ?", @pricemin)
      end
    end


    unless params[:prix_slider] == ''
      if params[:prix_slider]
        @annonces = @annonces.where("prix < ?", @pricemax)
        @annonces_pre = @annonces_pre.where("prix < ?", @pricemax)
      end
    end
    
    unless params[:pays_search2] == '' 
      if params[:pays_search2]
      @init_query_pays = Annonce.joins(:user).where( "users.paysresidence= ? ", "" )
        params[:pays_search2].each do |pays_var|
          @query_to_add_pays = Annonce.joins(:user).where( "users.paysresidence= ? ", pays_var )
          @result_query_pays = Annonce.from("(#{@init_query_pays.to_sql} UNION #{@query_to_add_pays.to_sql}) AS annonces")
          @init_query_pays = @result_query_pays
        end
        
        @annonces = Annonce.from("(#{@annonces.to_sql} INTERSECT #{@result_query_pays.to_sql}) AS annonces")
        @annonces_pre = Annonce.from("(#{@annonces_pre.to_sql} INTERSECT #{@result_query_pays.to_sql}) AS annonces")
        
        # @annonces = @result_query
        # @annonces_pre = Annonce.none
        # @annonces = @annonces.joins(:user).where({users: { paysresidence: @pays} })
        # @annonces_pre = @annonces_pre.joins(:user).where({users: { paysresidence: @pays} })   
      end
    end
    
    unless params[:volume_search2] == '' 
      if params[:volume_search2]
      @init_query_volume = Annonce.where( "volume = ? ", "pasdevolume" )
        params[:volume_search2].each do |volume_var|
          @query_to_add_volume = Annonce.where( "volume= ? ", volume_var )
          @result_query_volume = Annonce.from("(#{@init_query_volume.to_sql} UNION #{@query_to_add_volume.to_sql}) AS annonces")
          @init_query_volume = @result_query_volume
        end
        
        @annonces = Annonce.from("(#{@annonces.to_sql} INTERSECT #{@result_query_volume.to_sql}) AS annonces")
        @annonces_pre = Annonce.from("(#{@annonces_pre.to_sql} INTERSECT #{@result_query_volume.to_sql}) AS annonces")
        
      end
    end    
    
    unless params[:disposition_search2] == '' 
      if params[:disposition_search2]
      @init_query_disposition = Annonce.where( "disposition = ? ", "pasdedisposition" )
        params[:disposition_search2].each do |disposition_var|
          @query_to_add_disposition = Annonce.where( "disposition = ? ", disposition_var )
          @result_query_disposition = Annonce.from("(#{@init_query_disposition.to_sql} UNION #{@query_to_add_disposition.to_sql}) AS annonces")
          @init_query_disposition = @result_query_disposition
        end
        
        @annonces = Annonce.from("(#{@annonces.to_sql} INTERSECT #{@result_query_disposition.to_sql}) AS annonces")
        @annonces_pre = Annonce.from("(#{@annonces_pre.to_sql} INTERSECT #{@result_query_disposition.to_sql}) AS annonces")
        
      end
    end    
    
    unless params[:code_postal_search2] == '' 
      if params[:code_postal_search2]
      @init_query_code_postal = Annonce.joins(:user).where( "users.codepostal= ? ", 9999999 )
        params[:code_postal_search2].each do |code_postal_var|
          @query_to_add_code_postal = Annonce.joins(:user).where( "users.departement= ? ", code_postal_var )
          @result_query_code_postal = Annonce.from("(#{@init_query_code_postal.to_sql} UNION #{@query_to_add_code_postal.to_sql}) AS annonces")
          @init_query_code_postal = @result_query_code_postal
        end
        
        @annonces = Annonce.from("(#{@annonces.to_sql} INTERSECT #{@result_query_code_postal.to_sql}) AS annonces")
        @annonces_pre = Annonce.from("(#{@annonces_pre.to_sql} INTERSECT #{@result_query_code_postal.to_sql}) AS annonces")
        
        # @annonces = @result_query
        # @annonces_pre = Annonce.none
        # @annonces = @annonces.joins(:user).where({users: { paysresidence: @pays} })
        # @annonces_pre = @annonces_pre.joins(:user).where({users: { paysresidence: @pays} })   
      end
    end    
    
    unless params[:administratif_search2] == '' 
      if params[:administratif_search2]
      k = 0
      @init_query_administratif = Annonce.where( "disposition = ? ", "pasdedisposition" )
        params[:administratif_search2].each do |administratif_var|
          @query_to_add_administratif = Annonce.where( "#{administratif_var} = ? ", true )
          if k == 0
            @result_query_administratif = Annonce.from("(#{@init_query_administratif.to_sql} UNION #{@query_to_add_administratif.to_sql}) AS annonces")
            k += 1
          else
            @result_query_administratif = Annonce.from("(#{@init_query_administratif.to_sql} INTERSECT #{@query_to_add_administratif.to_sql}) AS annonces")
          end
          @init_query_administratif = @result_query_administratif
        end
        
        @annonces = Annonce.from("(#{@annonces.to_sql} INTERSECT #{@result_query_administratif.to_sql}) AS annonces")
        @annonces_pre = Annonce.from("(#{@annonces_pre.to_sql} INTERSECT #{@result_query_administratif.to_sql}) AS annonces")
        
      end
    end    
    
    # unless params[:disposition] == ''
    #   if params[:disposition]
    #     @annonces = @annonces.where("disposition = ?", @disposition)
    #     @annonces_pre = @annonces_pre.where("disposition = ?", @disposition)
    #   end
    # end
  
    # unless params[:facture_achat] == '' 
    #   if params[:facture_achat]
    #     @annonces = @annonces.where(facture_achat: @facture_achat)
    #     @annonces_pre = @annonces_pre.where(facture_achat: @facture_achat)
    #   end
    # end
    
    # unless params[:volume] == ''
    #   if params[:volume]
    #     puts @volume
    #     puts @volume.is_a? String
    #     @annonces = @annonces.where("volume = ?", @volume.to_s)
    #     @annonces_pre = @annonces_pre.where("volume = ?", @volume.to_s)
    #   end
    # end
    

    unless params[:categorie_search2] == '' 
      if params[:categorie_search2]
        Annonce.joins(:user).where("users.confirmation_webmaster = true").where(envente_yesno: true).each do |annonce_unitaire|
          categories_annonceunitaire = annonce_unitaire.categorie_annonces.collect {|u| u.categorie_id}
          params[:categorie_search2].each { |u| categories_choisies << u.to_i }
          if categories_choisies - categories_annonceunitaire == []
            @categorie_idarray << annonce_unitaire.id
          end
        end
        @annonces = @annonces.where(id: @categorie_idarray)
        @annonces_pre = @annonces_pre.where(id: @categorie_idarray)
      end
    end

    unless params[:courant_search2] == ''
      if params[:courant_search2]
        Annonce.joins(:user).where("users.confirmation_webmaster = true").where(envente_yesno: true).each do |annonce_unitaire|
          courants_annonceunitaire = annonce_unitaire.courant_ids
          params[:courant_search2].each { |u| courants_choisis << u.to_i }
          if courants_choisis - courants_annonceunitaire == []
            @courant_idarray << annonce_unitaire.id
          end
        end
        @annonces = @annonces.where(id: @courant_idarray)
        @annonces_pre = @annonces_pre.where(id: @courant_idarray)
      end
    end

    unless params[:couleur_search2] == ''
      if params[:couleur_search2]
        Annonce.joins(:user).where("users.confirmation_webmaster = true").where(envente_yesno: true).each do |annonce_unitaire|
          couleurs_annonceunitaire = annonce_unitaire.couleur_ids
          params[:couleur_search2].each { |u| couleurs_choisies << u.to_i }
          if couleurs_choisies - couleurs_annonceunitaire == []
            @couleur_idarray << annonce_unitaire.id
          end
        end
        @annonces = @annonces.where(id: @couleur_idarray)
        @annonces_pre = @annonces_pre.where(id: @couleur_idarray)
      end
    end
    
    # unless params[:code_postal] == '' 
    #   if params[:code_postal]
    #     # @annonces = @annonces.joins(:user).where(User.arel_table[:codepostal].as("TEXT").matches("#{@code_postal}%")  )
    #     # @annonces = @annonces.joins(:user).where("users.codepostal ILIKE ?", @code_postal.to_i.divmod(1000)[0].to_s)   
    #     # @annonces = @annonces.joins(:user).where({users: { codepostal: @code_postal} })   
    #     @annonces = @annonces.joins(:user).where({users: { codepostal: @code_postal} })
    #     @annonces_pre = @annonces_pre.joins(:user).where({users: { codepostal: @code_postal} })   
    #   end
    # end
    

    
    # unless params[:pays] == '' 
    #   if params[:pays]
    #     @annonces = @annonces.joins(:user).where({users: { paysresidence: @pays} })
    #     @annonces_pre = @annonces_pre.joins(:user).where({users: { paysresidence: @pays} })   
    #   end
    # end
  
    
    
    if params[:ordre_annonce] == '' || params[:ordre_annonce].nil?
      @annonces = @annonces.order('random()')
      @annonces_pre = @annonces_pre.order('random()')
    else
      if params[:ordre_annonce] == "PRIX CROISSANT"
        @annonces = @annonces.order('prix ASC')
        @annonces_pre = @annonces_pre.order('prix ASC')
        # @probleme = "Prix croissant"
      end
      if params[:ordre_annonce] == "PRIX DECROISSANT"
        @annonces = @annonces.order('prix DESC')
        @annonces_pre = @annonces_pre.order('prix DESC')
        # @probleme = "Prix decroissant"
      end
      if params[:ordre_annonce] == "DATE CREATION CROISSANT"
        @annonces = @annonces.order('anneecreation ASC')
        @annonces_pre = @annonces_pre.order('anneecreation ASC')
        # @probleme = "Prix decroissant"
      end
      if params[:ordre_annonce] == "DATE CREATION DECROISSANT"
        @annonces = @annonces.order('anneecreation DESC')
        @annonces_pre = @annonces_pre.order('anneecreation DESC')
        # @probleme = "Prix decroissant"
      end
      if params[:ordre_annonce] == "DATE ANNONCE CROISSANT"
        @annonces = @annonces.order('anneecreation ASC')
        @annonces_pre = @annonces_pre.order('anneecreation ASC')
        # @probleme = "Prix decroissant"
      end
      if params[:ordre_annonce] == "DATE ANNONCE DECROISSANT"
        @annonces = @annonces.order('anneecreation DESC')
        @annonces_pre = @annonces_pre.order('anneecreation DESC')
        # @probleme = "Prix decroissant"
      end
    end
    

    @annonces = @annonces.to_a
    @annonces_pre = @annonces_pre.to_a
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
    @annonce.update(annonce_params)
    unless  @annonce.largeur.nil? || @annonce.profondeur.nil? || @annonce.hauteur.nil?
      if @annonce.largeur > 0 && @annonce.profondeur > 0 && @annonce.hauteur > 0
        @volume = @annonce.largeur * @annonce.profondeur * @annonce.hauteur
        if @volume > 0.25
          if @volume > 1
            @annonce.update(volume: "g")
          else
            @annonce.update(volume: "m")
          end
        else
          @annonce.update(volume: "p")
        end
      end
    end
    unless @annonce.envente_yesno == nil
      @annonce.update(envente_yesno: nil)
      AnnonceMailer.with(user: @annonce.user, annonce: @annonce).confirm_edit_annonce.deliver_now
    end
    

    # @categoriesbdd = []
    # @couleursbdd = []
    # @courantsbdd = []

    # CategorieAnnonce.where(annonce_id: @annonce.id).each do |a|
    #   @categoriesbdd << a.categorie_id
    # end
    # CourantAnnonce.where(annonce_id: @annonce.id).each do |a|
    #   @courantsbdd << a.courant_id
    # end
    # CouleurAnnonce.where(annonce_id: @annonce.id).each do |a|
    #   @couleursbdd << a.couleur_id
    # end

    # unless params[:annonce][:categorie_annonces].nil?
    #   params[:annonce][:categorie_annonces].each do |id|
    #     unless @categoriesbdd.include?(id.to_i)
    #       unless id==""
    #         categorie = Categorie.find(id)
    #         categoriea = CategorieAnnonce.new( categorie: categorie, annonce_id: @annonce.id )
    #         categoriea.save!
    #       end
    #     end
    #   end
    # end


    # unless @categoriesbdd.nil?
    #   if params[:annonce][:categorie_annonces].nil?
    #     categoriedelall = CategorieAnnonce.where(annonce_id: @annonce.id)
    #     categoriedelall.each do |cat|
    #       cat.destroy
    #     end
    #   else
    #     @categoriesbdd.each do |id_db|
    #       unless params[:annonce][:categorie_annonces].include?(id_db.to_s)
    #         categoriedel = CategorieAnnonce.where(annonce_id: @annonce.id).where(categorie_id: id_db)
    #         categoriedel.each do |cat|
    #           cat.destroy
    #         end
    #       end
    #     end
    #   end
    # end

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
    
    
    # @annonce.update(annonce_params)
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
  
  def edit_formule
    @annonce = Annonce.find(params[:id])
  end
  
  def update_formule
    @annonce = Annonce.find(params[:id])
    @annonce.update(annonce_params)
    redirect_to users_me_path( :view_param => "annonce")
  end
  
  def contact_user
    @annonce = Annonce.find(params[:id])
  end
  
  def contact_deliver
    @annonce = Annonce.find(params[:id])
    @sujet = params[:annonce][:sujetcontact]
    @corps = params[:annonce][:corpscontact]
    @user = @annonce.user  
    AnnonceMailer.with(user: @user, annonce: @annonce, corps: @corps, sujet: @sujet, intercedant: current_user).contact_user_annonce.deliver_now
    redirect_to annonce_path(@annonce)
  end

  private

  def annonce_params
    params.require(:annonce).permit(:sujetcontact, :corpscontact, :volume, :pays, :code_postal, :ordre_annonce, :formule, :name, :anneecreation, :nom_artiste, :description, :photo, :photo_cache, :photo_un, :photo_un_cache, :photo_deux, :photo_deux_cache, :user_id, :prix, :format, :disposition, :hauteur, :largeur, :profondeur, :oeuvre_limite, :oeuvre_unique, :oeuvre_illimite, :facture_achat, :certificat_authenticite, :encadrement, :etat_neuf, :term, :categorie_search, :courant_search, :couleur_search, :prix_slider, categorie_annonces: [], courant_annonces: [], couleur_annonces: [], categorie_search2: [], courant_search2: [], administratif_search2: [], code_postal_search2: [], volume_search2: [], pays_search2: [], disposition_search2: [], couleur_search2: [], categories: [], courant_ids: [], couleur_ids: [], cat_ids: [])
  end
end

# {photo: []}
