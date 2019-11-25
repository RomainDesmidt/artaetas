ActionMailer::Base.smtp_settings = {
  address: 'smtp.sendgrid.net',
  port: 587,
  domain: 'http://artaetasv1.herokuapp.com',
  user_name: ENV['SENDGRID_USERNAME'],
  password: ENV['SENDGRID_PASSWORD'],
  authentication: :login,
  enable_starttls_auto: true
}
# ActionMailer::Base.smtp_settings = {
#   address: 'ssl0.ovh.net',
#   port: 465,
#   domain: 'http://artaetasv1.herokuapp.com',
#   user_name: ENV['OVH_USERNAME'],
#   password: ENV['OVH_MAIL_PASSWORD'],
#   authentication: :login,
#   enable_starttls_auto: true
# }