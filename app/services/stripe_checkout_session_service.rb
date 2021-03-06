class StripeCheckoutSessionService
  def call(event)
    order = Order.find_by(checkout_session_id: event.data.object.id)
    if order.premium_sku == "Don" || order.premium_sku == "Contribution"
      order.update(state: 'paid')
    else
      order.update(state: 'paid', ongoing_subscription: true)
      order.annonce.update(formule: order.premium_sku, last_sub_order: order.id)
    end
  end
end