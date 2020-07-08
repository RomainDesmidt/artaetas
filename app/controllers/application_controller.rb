class ApplicationController < ActionController::Base
  add_flash_types :success
  protect_from_forgery with: :exception
  before_action :store_user_location!, if: :storable_location?
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit( :username, :email, :password, :password_confirmation, :confirm_cgu  ) }
      devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit( :login, :username, :email, :password  ) }
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit( :current_password, :email, :username, :surname, :lastname, :afficher_identite, :afficher_email, :tel, :afficher_tel, :paysresidence, :villeresidence, :codepostal, :instagram, :facebook, :website, :description, :masquefavoris, :masquepublication, :statut, :photoprofil, :photoprofil_cache, :password, :password_confirmation, :photofond, :photofond_cache )}
    end
    
   # - The request is an Ajax request as this can lead to very unexpected behaviour.
    def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
    end

    def store_user_location!
      # :user is the scope we are authenticating
      store_location_for(:user, request.fullpath)
    end
    
    # def after_sign_in_path_for(resource)
    #   if (request.referer.include? "/users/sign_in")
    #     root_path
    #   # elseif (request.referer.include? "/admin/login")
    #   else
    #     request.referer
    #   end
    # end
end
