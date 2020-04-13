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
