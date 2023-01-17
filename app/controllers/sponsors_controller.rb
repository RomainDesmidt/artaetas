class SponsorsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  
  
    def index 
        @occurencemalu = Varlocale.where(nomchamp: "OccurenceMalu").first.valeurchamp.to_i
        @occurenceannonceurs = Varlocale.where(nomchamp: "OccurenceAnnonceurs").first.valeurchamp.to_i
        @startannonceurs = Varlocale.where(nomchamp: "DepartAnnonceurs").first.valeurchamp.to_i
        @annonces_confirmeduser = Annonce.joins(:user).where("users.confirmation_webmaster = true").where("annonces.archive = false")
        @annonces_all = @annonces_confirmeduser.where(envente_yesno: true)
        @landingp = 1
        @annonces_premium = @annonces_all.where(formule: "Mise a la une").order('random()')
        @annonces_standard = @annonces_all.where(formule: "Standard").or(@annonces_all.where(formule: "Mise en Avant")).order('random()')
        @annonceurs_all = Sponsor.all.where(publiee: true).order('random()')
        @annonces = @annonces_standard.to_a
        @annonces_pre = @annonces_premium.to_a
        @annonces_annonceurs = @annonceurs_all.to_a
        if current_user then
          Reporting.create!(userid: current_user.id, username: current_user.username, params: params, origin: "annonces index")  
        end         
    end
  
end