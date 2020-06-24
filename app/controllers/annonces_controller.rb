class AnnoncesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :search]

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
    @occurencemalu = Varlocale.where(nomchamp: "OccurenceMalu").first.valeurchamp
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
    @annonce.update(formule: "Standard")
    unless  @annonce.largeur.nil? ||  @annonce.hauteur.nil?
      #if @annonce.largeur > 0 && @annonce.profondeur > 0 && @annonce.hauteur > 0
      #  @volume = @annonce.largeur * @annonce.profondeur * @annonce.hauteur
      if @annonce.largeur > 0  && @annonce.hauteur > 0
        @volume = @annonce.largeur  * @annonce.hauteur
        if @volume > 2500
          if @volume > 10000
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

      redirect_to showannonces_path(@annonce.slug), flash: { success: "L'annonce est en attente de modération, et est consultable dans l'onglet annonce du compte membre" }
      # flash[:error] = "it worked"
    else
      render 'new'
      flash[:error] = "Erreur a la creation"
    end
  end

  def search
    # @pricemin = params[:pricemin]
    # @pricemax = params[:pricemax]
    @occurencemea = Varlocale.where(nomchamp: "OccurenceMea").first.valeurchamp
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
    @nom_artiste_search2 = params[:nom_artiste_search2]
    
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
    @code_postal_all = @code_postal_all.compact.sort.uniq
    @nom_artiste_all = Annonce.all.collect do |x| 
      unless x.nom_artiste.nil?
        x.nom_artiste.downcase.strip
      end
    end
    @nom_artiste_all = @nom_artiste_all.sort!.uniq!
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
    
    #if params[:term].nil?
      @annonces_all = Annonce.joins(:user).where("users.confirmation_webmaster = true").where(envente_yesno: true)
    #else
    #  @annonces_all = Annonce.joins(:user).where("users_annonces.confirmation_webmaster = true").where(envente_yesno: true)
   # end
    # @annonces_premium = @annonces_all.where(formule: "Mise en Avant").or(@annonces_all.where(formule: "Mise a la une")).order('random()')
    @annonces_premium = @annonces_all.where(formule: "Mise en Avant").or(@annonces_all.where(formule: "Mise a la une"))
    # @annonces_standard = @annonces_all.where(formule: "Standard").order('random()')
    @annonces_standard = @annonces_all.where(formule: "Standard")
    @annonces = @annonces_standard
    @annonces_pre = @annonces_premium
    
    #Annonce.joins(:courants, :cats, :couleurs).where("annonces.name = 'Nus' OR courants.name = 'Nus' OR categories.name = 'Nus' OR couleurs.couleur_dominante = 'Nus' ")
    #Annonce.joins("INNER JOIN \"courant_annonces\" ON \"courant_annonces\".\"annonce_id\" = \"annonces\".\"id\" INNER JOIN \"courants\" ON \"courants\".\"id\" = \"courant_annonces\".\"courant_id\"").where("courants.name = 'Nus'").first
    # Shown Annonces

    unless params[:term] == "Que recherchez-vous?"
      if params[:term]
      # @annonces = @annonces.where('annonces.name ILIKE ? OR annonces.description ILIKE ? ', "%#{params[:term]}%", "%#{params[:term]}%")
      # @annonces_pre = @annonces_pre.where('annonces.name ILIKE ? OR annonces.description ILIKE ? ', "%#{params[:term]}%", "%#{params[:term]}%")  
        @annonces_init = @annonces.where('annonces.name ILIKE ? OR annonces.description ILIKE ? OR annonces.nom_artiste ILIKE ? OR users.username ILIKE ?', "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%")
        @annonces_pre_init = @annonces_pre.where('annonces.name ILIKE ? OR annonces.description ILIKE ? OR annonces.nom_artiste ILIKE ? OR users.username ILIKE ?', "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%")
      
       #@annonces_courant = @annonces.joins("INNER JOIN \"courant_annonces\" ON \"courant_annonces\".\"annonce_id\" = \"annonces\".\"id\" INNER JOIN \"courants\" ON \"courants\".\"id\" = \"courant_annonces\".\"courant_id\"").where('courants.name ILIKE ?', "%#{params[:term]}%" )
       #@annonces_pre_courant = @annonces_pre.joins("INNER JOIN \"courant_annonces\" ON \"courant_annonces\".\"annonce_id\" = \"annonces\".\"id\" INNER JOIN \"courants\" ON \"courants\".\"id\" = \"courant_annonces\".\"courant_id\"").where('courants.name ILIKE ?', "%#{params[:term]}%")
       #@annonces = Annonce.from("(#{@annonces_init.to_sql} UNION #{@annonces_courant.to_sql}) AS annonces")
       #@annonces_pre = Annonce.from("(#{@annonces_pre_init.to_sql} UNION #{@annonces_pre_courant.to_sql}) AS annonces")
      
      #---------------- WORKING ------------------------------------
      @annonces_courant = @annonces.joins(:courants).where("courants.name ILIKE ? ", "%#{params[:term]}%" )
      @annonces_pre_courant = @annonces_pre.joins(:courants).where("courants.name ILIKE ? ", "%#{params[:term]}%" )
      
      @annonces_cat = @annonces.joins(:cats).where("categories.name ILIKE ? ", "%#{params[:term]}%" )
      @annonces_pre_cat = @annonces_pre.joins(:cats).where("categories.name ILIKE ? ", "%#{params[:term]}%" )
      
      @annonces_couleur = @annonces.joins(:couleurs).where("couleurs.couleur_dominante ILIKE ? ", "%#{params[:term]}%" )
      @annonces_pre_couleur = @annonces_pre.joins(:couleurs).where("couleurs.couleur_dominante ILIKE ? ", "%#{params[:term]}%" )
      
      @annonces_deux = Annonce.from("(#{@annonces_init.to_sql} UNION #{@annonces_courant.to_sql}) AS annonces")
      @annonces_pre_deux = Annonce.from("(#{@annonces_pre_init.to_sql} UNION #{@annonces_pre_courant.to_sql}) AS annonces")
      
      @annonces_trois = Annonce.from("(#{@annonces_deux.to_sql} UNION #{@annonces_cat.to_sql}) AS annonces")
      @annonces_pre_trois  = Annonce.from("(#{@annonces_pre_deux.to_sql} UNION #{@annonces_pre_cat.to_sql}) AS annonces")
      
      @annonces = Annonce.from("(#{@annonces_trois.to_sql} UNION #{@annonces_couleur.to_sql}) AS annonces")
      @annonces_pre = Annonce.from("(#{@annonces_pre_trois.to_sql} UNION #{@annonces_pre_couleur.to_sql}) AS annonces")
      #---------------- END ------------------------------------------
      # @annonces_courant = @annonces.joins(:courants).where("courants.name ILIKE ? ", "%#{params[:term]}%" )
      # @annonces_pre_courant = @annonces_pre.joins(:courants).where("courants.name ILIKE ? ", "%#{params[:term]}%" )
      # @annonces = Annonce.from("(#{@annonces_init.to_sql} UNION #{@annonces_courant.to_sql}) AS annonces")
      # @annonces_pre = Annonce.from("(#{@annonces_pre_init.to_sql} UNION #{@annonces_pre_courant.to_sql}) AS annonces")
      
      
      #@annonces = @annonces.search_annonce(params[:term])
      #@annonces_pre = @annonces_pre.search_annonce(params[:term])
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
    
    unless params[:nom_artiste_search2] == '' 
      if params[:nom_artiste_search2]
        @init_query_nom_artiste = Annonce.where( "nom_artiste ILIKE ? ", "pas de nom d'artiste" )
        params[:nom_artiste_search2].each do |nom_artiste_var|
          
          @query_to_add_nom_artiste = Annonce.where( "nom_artiste ILIKE ? ", "%#{nom_artiste_var}%" )
          
          @result_query_nom_artiste = Annonce.from("(#{@init_query_nom_artiste.to_sql} UNION #{@query_to_add_nom_artiste.to_sql}) AS annonces")
          @init_query_nom_artiste = @result_query_nom_artiste
          
      
        end
        #if b > 1 
          @annonces = Annonce.from("(#{@annonces.to_sql} INTERSECT #{@result_query_nom_artiste.to_sql}) AS annonces")
          @annonces_pre = Annonce.from("(#{@annonces_pre.to_sql} INTERSECT #{@result_query_nom_artiste.to_sql}) AS annonces")
        #end
        
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
    
    # unless params[:term] == "Que recherchez-vous?"
    #   if params[:term]
    #   # @annonces = @annonces.where('annonces.name ILIKE ? OR annonces.description ILIKE ?', "%#{params[:term]}%", "%#{params[:term]}%")
    #   # @annonces_pre = @annonces_pre.where('annonces.name ILIKE ? OR annonces.description ILIKE ?', "%#{params[:term]}%", "%#{params[:term]}%")
    #   @annonces = @annonces.search_annonce(params[:term])
    #   @annonces_pre = @annonces_pre.search_annonce(params[:term])
    #   end
    # end
    

    @annonces = @annonces.to_a
    @annonces_pre = @annonces_pre.to_a
  end


  def show
    # @annonces = Annonce.find(params[:id])
    @annonces = Annonce.where(slug: params[:slug]).first
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
    unless  @annonce.largeur.nil? ||  @annonce.hauteur.nil?
      #if @annonce.largeur > 0 && @annonce.profondeur > 0 && @annonce.hauteur > 0
      #  @volume = @annonce.largeur * @annonce.profondeur * @annonce.hauteur
      if @annonce.largeur > 0  && @annonce.hauteur > 0
        @volume = @annonce.largeur  * @annonce.hauteur
        if @volume > 2500
          if @volume > 10000
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
    
    if  @annonce.save
      redirect_to showannonces_path(@annonce.slug), flash: { success: "L'annonce est en attente de modération, et est consultable dans l'onglet annonce du compte membre" }
      # flash[:error] = "it worked"
    else
      render 'edit'
      flash[:error] = "Erreur d'edition"
    end
    
  end

  def destroy
    @annonce = Annonce.find(params[:id])

    unless Order.all.where(annonce_id: @annonce.id).nil?
      Order.all.where(annonce_id: @annonce.id).destroy_all
    end
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
    # redirect_to users_me_path( :view_param => "annonce")
    redirect_to users_mesannonces_path
  end


  
  def bookmark
    @annonce = Annonce.find(params[:id])
    current_user.bookmark(@annonce)
    redirect_to showannonces_path(@annonce.slug)
  end
  
  def unbookmark
    @annonce = Annonce.find(params[:id])
    current_user.unbookmark(@annonce)
    redirect_to showannonces_path(@annonce.slug)
  end
  
  
  def like
    @annonce = Annonce.find(params[:id])
    @annonce.liked_by current_user
    redirect_to showannonces_path(@annonce.slug)
  end

  def likeuser
    @annonce = Annonce.find(params[:id])
    @user = User.find(@annonce.user_id)
    @user.liked_by current_user
    redirect_to showannonces_path(@annonce.slug)
  end

  def dislike   
    @annonce = Annonce.find(params[:id])
    @annonce.disliked_by current_user
    redirect_to showannonces_path(@annonce.slug)
  end

  def dislikeuser
    @annonce = Annonce.find(params[:id])
    @user = User.find(@annonce.user_id)
    @user.disliked_by current_user
    redirect_to showannonces_path(@annonce.slug)
  end

  def follow
    @annonce = Annonce.find(params[:id])
    @user = User.find(@annonce.user_id)
    @user.followers << current_user
    # redirect_to @annonce
    redirect_back fallback_location: root_path, flash: { success: "Le membre est suivi, vous pouvez accéder à la liste des membres suivis dans votre compte membre!" }
  end

  def unfollow
    @annonce = Annonce.find(params[:id])
    @user = User.find(@annonce.user_id)
    Follow.where(follower_id: current_user.id, followee_id: @user.id).first.destroy!
    # redirect_to @annonce
    redirect_back fallback_location: root_path, flash: { success: "Le membre n'est plus suivi!" }
  end
  
  def follow_user
    @user = User.find(params[:id])
    @user.followers << current_user
    # redirect_to @annonce
    redirect_back fallback_location: root_path, flash: { success: "Le membre est suivi, vous pouvez accéder à la liste des membres suivis dans votre compte membre!" }
  end

  def unfollow_user
    @user = User.find(params[:id])
    Follow.where(follower_id: current_user.id, followee_id: @user.id).first.destroy!
    # redirect_to @annonce
    redirect_back fallback_location: root_path, flash: { success: "Le membre n'est plus suivi!" }
  end
  
  
  def edit_formule
    @countmea = Annonce.where(formule: "Mise en Avant").count
    @countmalu = Annonce.where(formule: "Mise a la une").count
    @limmaxmea = Varlocale.where(nomchamp: "LimMaxMea").first.valeurchamp
    @limmaxmalu = Varlocale.where(nomchamp: "LimMaxMalu").first.valeurchamp
    @annonce = Annonce.find(params[:id])
  end
  
  def update_formule
    @annonce = Annonce.find(params[:id])
    @annonce.update(annonce_params)
    # redirect_to users_me_path( :view_param => "annonce")
    redirect_to users_mesannonces_path
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
    redirect_to showannonces_path(@annonce.slug), flash: { success: "Le message a été envoyé." }
  end

  private

  def annonce_params
    params.require(:annonce).permit( :envente_yesno, :sujetcontact, :corpscontact, :volume, :pays, :code_postal, :ordre_annonce, :formule, :name, :anneecreation, :nom_artiste, :description, :photo, :photo_cache, :photo_un, :photo_un_cache, :photo_deux, :photo_deux_cache, :user_id, :prix, :format, :disposition, :hauteur, :largeur, :profondeur, :oeuvre_limite, :oeuvre_unique, :oeuvre_illimite, :facture_achat, :certificat_authenticite, :encadrement, :etat_neuf, :term, :categorie_search, :courant_search, :couleur_search, :prix_slider, categorie_annonces: [], courant_annonces: [], couleur_annonces: [], categorie_search2: [], courant_search2: [], administratif_search2: [], code_postal_search2: [], nom_artiste_search2: [], volume_search2: [], pays_search2: [], disposition_search2: [], couleur_search2: [], categories: [], courant_ids: [], couleur_ids: [], cat_ids: [])
  end
end

# {photo: []}
