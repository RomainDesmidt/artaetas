class AdminMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin_mailer.confirm_user.subject
  #
  def confirm_user_annonce
    @user = params[:user] # Instance variable => available in view
    mail(to: @user.email, subject: 'Votre annonce sur ARTAETAS est en ligne !')
    # This will render a view in `app/views/user_mailer`!
  end
  
  def refuse_user_annonce
    @user = params[:user] # Instance variable => available in view
    mail(to: @user.email, subject: 'Votre annonce sur ARTAETAS n’est pas conforme à nos CGU.')
    # This will render a view in `app/views/user_mailer`!
  end
end
