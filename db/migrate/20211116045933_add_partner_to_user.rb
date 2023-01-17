class AddPartnerToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :partner, :boolean
  end
end
