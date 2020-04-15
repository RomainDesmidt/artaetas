class OrdersController < ApplicationController
    def create
      @countmea = Annonce.where(formule: "Mise en Avant").count
      @countmalu = Annonce.where(formule: "Mise a la une").count
      @limmaxmea = Varlocale.where(nomchamp: "LimMaxMea").first.valeurchamp
      @limmaxmalu = Varlocale.where(nomchamp: "LimMaxMalu").first.valeurchamp
      annonce = Annonce.find(params[:annonce_id])
      premium_formule = params[:premium_formule]
      case premium_formule 
      when "Mise en Avant"
        if @countmea >= @limmaxmea
          redirect_to edit_formule_annonce_path(annonce.id), flash: { success: "Le quotat de Mise en avant est atteint !" }
          return
        end
        amount_premium = Varlocale.where(nomchamp: "PrixMea").first.valeurchamp
      when "Mise a la une"
        if @countmalu >= @limmaxmalu
          redirect_to edit_formule_annonce_path(annonce.id), flash: { success: "Le quotat de Mise a la une est atteint !" }
          return
        end
        amount_premium = Varlocale.where(nomchamp: "PrixMalu").first.valeurchamp
      end
      amount_stripe = amount_premium
      order  = Order.create!(annonce: annonce, premium_sku: premium_formule, amount: (amount_premium/100), state: 'pending', user: current_user)
    
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
    
    def show
      @order = Order.find(params[:id])
      @state = @order.state
    end
end
