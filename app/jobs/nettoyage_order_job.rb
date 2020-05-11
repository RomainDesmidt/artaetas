class NettoyageOrderJob < ApplicationJob
  include SuckerPunch::Job
  queue_as :default

  def perform
    require 'stripe'
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    ActiveRecord::Base.connection_pool.with_connection do
      Order.where(state: "pending").each do |order|
        puts "l'id de la session est : #{order.checkout_session_id}"
        puts "l'id de l'order est : #{order.id}"
        query_checkout = Stripe::Checkout::Session.retrieve(
          order.checkout_session_id,
        )
        sleep 2
        query_payment = Stripe::PaymentIntent.retrieve(
          query_checkout["payment_intent"],
        )
        puts query_payment["status"]
        sleep 2
      end
    end
  end
end
