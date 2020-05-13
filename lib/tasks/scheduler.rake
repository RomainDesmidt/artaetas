desc "This task is called by the Heroku scheduler add-on, should modify premium annonce to turn to standard if its subscription ended"
task :modify_annonce => :environment do
  old_name = Annonce.find(20).name
  new_name = old_name + "+"
  Annonce.find(20).update(name: new_name)
end

task :check_periode_malu => :environment do
  @periode_malu = Varlocale.where(nomchamp: "PeriodeMalu").first.valeurchamp
  Order.where(ongoing_subscription: true).where(premium_sku: "Mise a la une").each do |order|
    if order.updated_at < @periode_malu.days.ago
      order.update(ongoing_subscription: false)
      order.annonce.update(formule: "Standard", last_sub_order: nil)
    end
  end
end

task :check_periode_mea => :environment do
  @periode_mea = Varlocale.where(nomchamp: "PeriodeMea").first.valeurchamp
  Order.where(ongoing_subscription: true).where(premium_sku: "Mise en Avant").each do |order|
    if order.updated_at < @periode_mea.days.ago
      order.update(ongoing_subscription: false)
      order.annonce.update(formule: "Standard", last_sub_order: nil)
    end
  end
end

task :check_periode_propre => :environment do
    require 'stripe'
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    unless Order.where(state: "pending").first.nil?
      Order.where(state: "pending").each do |order|
        unless order.checkout_session_id.nil?
          unless order.checkout_session_id.include? "cs_test"
              query_checkout = Stripe::Checkout::Session.retrieve(
                order.checkout_session_id,
              )
              sleep 2
              query_payment = Stripe::PaymentIntent.retrieve(
                query_checkout["payment_intent"],
              )
              case query_payment["status"]
              when "canceled"
                  order.update(state: "canceled")
              when "requires_payment_method"
                  order.update(state: "canceled")
              else
                  order.update(state: query_payment["status"])
              end
              sleep 2
          end
        end
      end
    end
end

task :delete_canceled_safe => :environment do
  Order.where(state: "canceled").where("created_at < ?", 2.days.ago).destroy_all
end