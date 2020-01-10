class ApplicationController < ActionController::Base
  add_flash_types :success
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit( :username, :email, :password, :password_confirmation, :confirm_cgu  ) }
      devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit( :login, :username, :email, :password  ) }
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit( :current_password, :email, :username, :surname, :lastname, :afficher_identite, :afficher_email, :tel, :afficher_tel, :paysresidence, :villeresidence, :codepostal, :instagram, :facebook, :website, :description, :masquefavoris, :masquepublication, :statut, :photoprofil, :photoprofil_cache, :password, :password_confirmation, :photofond, :photofond_cache )}
    end
    

end
