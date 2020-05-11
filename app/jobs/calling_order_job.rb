class CallingOrderJob < ApplicationJob
  include SuckerPunch::Job
  queue_as :default

  def perform(id_order)
    require 'stripe'
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    # puts id_order
    # puts id_order.is_a? Integer
    ActiveRecord::Base.connection_pool.with_connection do
      # Order.where(state: "pending").each do |order|
      #     puts order.checkout_session_id
      #     sleep 4
      # end
      order =  Order.find(id_order)
      query_checkout = Stripe::Checkout::Session.retrieve(
            order.checkout_session_id,
      )
      sleep 2
      query_payment = Stripe::PaymentIntent.retrieve(
        query_checkout["payment_intent"],
      )
      # case query_payment["status"]
      # when "canceled"
      #   order.update(state: "canceled")
      # when "requires_payment_method"
      #   order.update(state: "requires_payment_method")
      # end
    end
  end
end
