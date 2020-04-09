class AddOngoingSubscriptionToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :ongoing_subscription, :boolean
  end
end
