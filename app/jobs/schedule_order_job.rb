class ScheduleOrderJob < ApplicationJob
  include SuckerPunch::Job
  queue_as :default

  def perform(id_order)
    require 'stripe'
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    ActiveRecord::Base.connection_pool.with_connection do
      order = Order.find(id_order)
      unless order.checkout_session_id.nil?
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
        end
      end
    end
  end
end
