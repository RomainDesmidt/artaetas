class AnnonceMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin_mailer.confirm_user.subject
  #
  def confirm_edit_annonce
    @user = params[:user] # Instance variable => available in view
    @annonce = params[:annonce]
    mail(to: @user.email, subject: 'Votre annonce est en attente de moderation !')
    # This will render a view in `app/views/user_mailer`!
  end
  

end
