class OrdersController < ApplicationController
    def create
      annonce = Annonce.find(params[:annonce_id])
      premium_formule = params[:premium_formule]
      case premium_formule 
      when "Mise en Avant"
        amount_premium = 5
      when "Mise a la une"
        amount_premium = 10
      end
      amount_stripe = amount_premium * 100
      order  = Order.create!(annonce: annonce, premium_sku: premium_formule, amount: amount_premium, state: 'pending', user: current_user)
    
      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [{
          name: annonce.name,
          images: [annonce.photo_url],
          amount: amount_stripe,
          currency: 'eur',
          quantity: 1
        }],
        success_url: order_url(order),
        cancel_url: new_order_payment_url(order)
      )
    
      order.update(checkout_session_id: session.id)
      redirect_to new_order_payment_path(order)
    end
end
