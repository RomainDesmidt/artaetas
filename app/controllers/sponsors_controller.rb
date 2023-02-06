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
        #@annonces_shadowpush.each_with_index { |index,annonce| @annonces_shadowpush.pop if (index > @numbersp)   }

  
        
        #TEST
        #@annonces_shadowpush
        #Annonce.joins(:user).where("users.confirmation_webmaster = true").where("annonces.archive = false").where(envente_yesno: true).where(shadow_push: true).order('random()')
        
        #@annonces_premium
        #Annonce.joins(:user).where("users.confirmation_webmaster = true").where("annonces.archive = false").where(envente_yesno: true).where(formule: "Mise a la une").order('random()')
        
        #@annonces_normal
        #Annonce.joins(:user).where("users.confirmation_webmaster = true").where("annonces.archive = false").where(envente_yesno: true)
        
        #annonces_n = Annonce.joins(:user).where("users.confirmation_webmaster = true").where("annonces.archive = false").where(envente_yesno: true)
        #annonce_sp = Annonce.joins(:user).where("users.confirmation_webmaster = true").where("annonces.archive = false").where(envente_yesno: true).where(shadow_push: true).order('random()')
        #queryannonce = Annonce.where(shadow_push: true)
        #annonces_n.each  {|a| annonces_n_a << a  unless (a.shadow_push == true || a.formule == "Mise a la une")}
        #annonce_sp.each {|x| puts "hw" if annonces_n.include?(x)}
        
        #@numbersp
        #(annonce_premiumcount * pourcentspush) / (1-pourcentspush)
        @pourcentpush = Varlocale.where(nomchamp: "ShadowPush").first.valeurchamp.to_f / 100
        @annonces_shadowpush = @annonces_confirmeduser.where(envente_yesno: true).where(shadow_push: true).order('random()')
        @countpremium = @annonces_premium.count
        #puts "---------"
        #puts "TEST AREA"
        #puts "---------"
        #puts @countpremium
        @numbersp = ((@countpremium * @pourcentpush) / (1-@pourcentpush)).round        
        @annonces_shadowpush_min = @annonces_shadowpush.slice(0,@numbersp)
        #@annonces_premium = @annonces_premium.append(@annonces_shadowpush)
        
        @annonces_standard_wsp = @annonces_all.where(formule: "Standard").or(@annonces_all.where(formule: "Mise en Avant")).order('random()')
        @annonces = []
        #@annonces_standard_wsp.each  {|a| @annonces << a  unless (a.shadow_push == true || a.formule == "Mise a la une")}
        
        @annonceurs_all = Sponsor.all.where(publiee: true).order('random()')
        #@annonces = @annonces_standard.to_a
        
        @annonce_pre_beforesp = @annonces_premium.to_a
        @annonces_shadowpush_min.to_a.each { |elem| @annonce_pre_beforesp.append(elem) }
        
        @annonces_standard_wsp.each  {|a| @annonces << a  unless (@annonce_pre_beforesp.include?(a) || a.formule == "Mise a la une")}
        
        @annonces_pre = @annonce_pre_beforesp
        @annonces_annonceurs = @annonceurs_all.to_a
        if current_user then
          Reporting.create!(userid: current_user.id, username: current_user.username, params: params, origin: "annonces index")  
        end         
    end
  
end