class OrdersController < ApplicationController
    #skip_before_action :authenticate_user!, only: [:show]
    #skip_before_action :authenticate_active_admin_user, only: [:show]
    
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
        success_url: facturepdf_url(order.slug, order.id),
        cancel_url: new_order_payment_url(order)
      )
    
      order.update(checkout_session_id: session.id)
      redirect_to new_order_payment_path(order)
    end
    
    def donate
      annonce = Annonce.find(params[:annonce_id])
      if annonce.id == 1
        premium_formule = "Contribution"
      else
        premium_formule = "Don"
      end
      amount_premium = params[:montant].to_i*100
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
        success_url: facturepdf_url(order.slug, order.id),
        cancel_url: new_order_payment_url(order)
      )
    
      order.update(checkout_session_id: session.id)
      redirect_to new_order_payment_path(order)
    end
    
    def show
      @order = Order.where(slug: params[:slug]).first
      #@order = Order.find(params[:id])
      @state = @order.state
      Mime::Type.register "application/pdf", :pdf
      require 'invoice_printer'
      
      case @state
      when "gifted"
        @state_fr = "Non payé"
      when "pending"
        @state_fr = "En Attente"
      when "paid"
        @state_fr = "Payé"
      end
      InvoicePrinter.labels = {
        name: 'Facture',
        provider: 'Fournisseur',
        purchaser: 'Acheteur',
        tax_id: 'Identification number',
        tax_id2: 'Identification number',
        payment: 'Paiement',
        payment_by_transfer: 'Statut : '+@state_fr,
        payment_in_cash: 'Payment in cash',
        account_number: 'Moyen de paiement:',
        swift: 'SWIFT',
        iban: 'IBAN',
        issue_date: 'Date :',
        due_date: 'Expire le :',
        item: 'Titre',
        variable: '',
        quantity: 'Type',
        unit: 'Periode',
        price_per_item: 'Formule',
        amount: 'Montant',
        tax: 'Tax',
        tax2: 'Tax 2',
        tax3: 'Tax 3',
        subtotal: 'Sous total hors taxes',
        total: 'Total net'
      }
      
      
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
        provider_name: 'YOURARTAVENUE SASU',
        # Deprecated 1.3 API, use provider_lines
        # Here for compatibility test
        provider_street: '24 allée des allumoirs',
        provider_street_number: '',
        provider_postcode: '59493 VILLENEUVE D\'ASCQ, FRANCE',
        provider_city: '',
        provider_city_part: '',
        provider_extra_address_line: '',
        purchaser_name: @order.annonce.user.email,
        # Deprecated 1.3 API, use purchaser_lines
        # Here for compatibility test
        purchaser_street: (@order.annonce.user.surname.nil? ? "" : @order.annonce.user.surname )+' '+(@order.annonce.user.lastname.nil? ? "" : @order.annonce.user.lastname ),
        purchaser_street_number: '' ,
        purchaser_postcode: (@order.annonce.user.codepostal.nil? ? "" : @order.annonce.user.codepostal.to_s )+' '+(@order.annonce.user.villeresidence.nil? ? "" : @order.annonce.user.villeresidence ), 
        purchaser_city: '',
        issue_date: @order.updated_at.strftime("%d/%m/%Y").to_s,
        due_date: (@order.updated_at+7.days).strftime("%d/%m/%Y").to_s,
        subtotal: '',
        total: @order.amount.to_s+' €',
        bank_account_number: "Carte de credit (Stripe)",
        items: [item],
        #note: 'TVA non applicable, art.293 B du CGI'
      )
      respond_to do |format|
        format.html
        format.pdf do
          @pdf = InvoicePrinter.render(
            document: invoice,
            background: File.expand_path('../../assets/images/background_feinte5.png', __FILE__),
            font: File.expand_path('../../assets/fonts/roboto/Roboto-Regular.ttf', __FILE__)
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
