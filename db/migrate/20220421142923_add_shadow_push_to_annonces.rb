class AddShadowPushToAnnonces < ActiveRecord::Migration[5.2]
  def change
    add_column :annonces, :shadow_push, :boolean, default: false
  end
end
