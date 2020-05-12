desc "Nettoie la liste des order en attente"
task :monsieur_propre => :environment do
    require 'stripe'
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
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

