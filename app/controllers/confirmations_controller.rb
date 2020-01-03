class ConfirmationsController < Devise::ConfirmationsController
  private
  def after_confirmation_path_for(resource_name, resource)
    sign_in(resource) # In case you want to sign in the user
    redirect_to root_path, flash: { success: "Nous vous invitons à compléter votre profil !" }
    # redirect_to users_me_path( :view_param => "annonce")
  end
end