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
      Mime::Type.register "application/pdf", :pdf
      require 'invoice_printer'
      
      item = InvoicePrinter::Document::Item.new(
        name: @order.annonce.name.lines.first[0,30]+(@order.annonce.name.lines.first[31].nil? ? "" : "...") ,
        quantity: "Annonce" ,
        unit: '7 jours',
        price: @order.premium_sku,
        amount: @order.amount.to_s+' €'
      )
      
      # @provider_address = <<~ADDRESS
      # Rolnická 1
      # 747 05  Opava
      # Kateřinky
      # ADDRESS
      
      # @purchaser_address = <<~ADDRESS
      # Ostravská 1
      # 747 70  Opava
      # ADDRESS
      
      invoice = InvoicePrinter::Document.new(
        number: 'No.'+@order.updated_at.strftime("%Y%m%d").to_s+@order.id.to_s,
        provider_name: 'ARTAETAS',
        # Deprecated 1.3 API, use provider_lines
        # Here for compatibility test
        provider_street: 'http://www.artaetas.com',
        provider_street_number: '',
        provider_postcode: '',
        provider_city: '',
        purchaser_name: @order.annonce.user.username,
        # Deprecated 1.3 API, use purchaser_lines
        # Here for compatibility test
        purchaser_street: @order.annonce.user.surname+' '+@order.annonce.user.lastname,
        purchaser_street_number: '' ,
        purchaser_postcode: '' ,
        purchaser_city: '',
        issue_date: @order.updated_at.strftime("%d/%m/%Y").to_s,
        due_date: (@order.updated_at+7.days).strftime("%d/%m/%Y").to_s,
        total: @order.amount.to_s+' €',
        bank_account_number: 'YOURARTAVENUE SAS',
        items: [item],
        note: ''
      )
      respond_to do |format|
        format.html
        format.pdf do
          @pdf = InvoicePrinter.render(
            document: invoice
          )
          send_data @pdf, type: 'application/pdf', disposition: 'inline'
          # InvoicePrinter.print(
          #   document: invoice,
          #   file_name: 'invoice.pdf'
          # )
        end      
      end
    end
end
