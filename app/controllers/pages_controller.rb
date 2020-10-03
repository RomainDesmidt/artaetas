class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home,:social, :cgu, :politiquedeconfidentialite, :mentionslegales, :quisommesnous, :faq, :canttouchthis]

  def home
  end
  
  def cgu
  end
  
  def faq
  end
  
  def quisommesnous
  end

  def politiquedeconfidentialite
  end
  
  def mentionslegales
  end
  
  def canttouchthis
    
    # @occurencemalu = Varlocale.where(nomchamp: "OccurenceMalu").first.valeurchamp
    # @annonces_confirmeduser = Annonce.joins(:user).where("users.confirmation_webmaster = true").where("annonces.archive = false")
    # @annonces_all = @annonces_confirmeduser.where(envente_yesno: true)
    # @landingp = 1
    # @annonces_premium = Sponsor.all
    # @annonces_standard = @annonces_all.where(formule: "Standard").or(@annonces_all.where(formule: "Mise en Avant")).order('random()')
    # @annonces = @annonces_standard.to_a
    # @annonces_pre = @annonces_premium.to_a
    
    @occurencemalu = Varlocale.where(nomchamp: "OccurenceMalu").first.valeurchamp.to_i
    @occurenceannonceurs = Varlocale.where(nomchamp: "OccurenceAnnonceurs").first.valeurchamp.to_i
    @startannonceurs = Varlocale.where(nomchamp: "DepartAnnonceurs").first.valeurchamp.to_i
    @annonces_confirmeduser = Annonce.joins(:user).where("users.confirmation_webmaster = true").where("annonces.archive = false")
    @annonces_all = @annonces_confirmeduser.where(envente_yesno: true)
    @landingp = 1
    @annonces_premium = @annonces_all.where(formule: "Mise a la une").order('random()')
    @annonces_standard = @annonces_all.where(formule: "Standard").or(@annonces_all.where(formule: "Mise en Avant")).order('random()')
    @annonceurs_all = Sponsor.all.order('random()')
    @annonces = @annonces_standard.to_a
    @annonces_pre = @annonces_premium.to_a
    @annonces_annonceurs = @annonceurs_all.to_a
    
    
  end

  def styleguide
    @base_font   = "Roboto"
    @header_font = "Raleway"
  end
  
  def changelog
  end
  
  def don
    @annonce = Annonce.find(1)
  end
  
  def sidekiqtest
    NettoyageOrderJob.perform_in(5)
    flash[:notice] = "Performing now"
    # redirect_to root
  end
  
  def imglist
    @imghash = []
    @imgarray = []
    @userhash = []
    @userarray = []
    Annonce.all.each do |annonce|
      @imgarray << annonce.id
      if annonce.photo?
        @imgarray << annonce.photo.file.public_id
      else
        @imgarray << "none"
      end
      if annonce.photo_un?
        @imgarray << annonce.photo_un.file.public_id
      else
        @imgarray << "none"
      end
      if annonce.photo_deux?
        @imgarray << annonce.photo_deux.file.public_id
      else
        @imgarray << "none"
      end
      @imghash << @imgarray
      @imgarray = []
    end
    
    User.all.each do |user_un|
      @userarray << user_un.id
      if user_un.photofond?
        @userarray << user_un.photofond.file.public_id
      else
        @userarray << "none"
      end
      if user_un.photoprofil?
        @userarray << user_un.photoprofil.file.public_id
      else
        @userarray << "none"
      end
      @userhash << @userarray
      @userarray = []
    end
    
    
  end
end
