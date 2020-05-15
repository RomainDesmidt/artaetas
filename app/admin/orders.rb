ActiveAdmin.register Order do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
controller do
  def pdfshow
      @order = Order.find(params[:id])
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
      when "canceled"
        @state_fr = "Annulé"
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
        note: ''
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

  index do
    style do
      [".col-sub{width: 25px}; "].join(' ')
    end
    style do
      [".col-annonce{width: 400px}; "].join(' ')
    end
    id_column
    column "Sub", :ongoing_subscription
    column "Etat", :state, sortable: "state" do |item|
      case item.state
      when "pending"
        "Non payée"
      when "paid"
        "Payée"
      when "gifted"
        "Offerte"
      when "canceled"
        "Annulée"
      end
    end
    column "Formule", :premium_sku
    column "Montant", :amount do |item|
      item.amount.to_s+" €"
    end
    column :user
    column :annonce, :'max-width' => "200px", :'min-width' => "200px"
    actions
    column "Facture" do |item|
      if (item.state == "gifted" ||  item.state == "paid")
        link_to "PDF", admin_orders_pdfshow_path(item, format: "pdf")
      end
    end
  end


  action_item :touchpdf, only: [:show], if: proc { (Order.find(params[:id]).state == "paid" || Order.find(params[:id]).state == "gifted" || Order.find(params[:id]).state == "pending"   ) }  do 
    link_to "PDF", admin_orders_pdfshow_path(Order.find(params[:id]), format: "pdf")
  end
  

  action_item :touchjour, only: [:show], if: proc { Order.find(params[:id]).ongoing_subscription == true }  do 
    link_to 'RaZ', renewday_admin_order_path, method: :put
  end
  
  member_action :renewday, :method => :put do
    @modif_order = Order.find(params[:id])
    @modif_order.touch
    redirect_to admin_order_path
  end

  action_item :extunjour, only: [:show], if: proc { Order.find(params[:id]).ongoing_subscription == true }  do 
    link_to 'Jour+', onemoreday_admin_order_path, method: :put
  end
  
  member_action :onemoreday, :method => :put do
    @modif_order = Order.find(params[:id])
    @modif_order.update(updated_at: @modif_order.updated_at + 1.day )
    redirect_to admin_order_path
  end
  
 action_item :remunjour, only: [:show], if: proc { Order.find(params[:id]).ongoing_subscription == true }  do 
    link_to 'Jour-', onelessday_admin_order_path, method: :put
  end
  
  member_action :onelessday, :method => :put do
    @modif_order = Order.find(params[:id])
    @modif_order.update(updated_at: @modif_order.updated_at - 1.day )
    redirect_to admin_order_path
  end

end
