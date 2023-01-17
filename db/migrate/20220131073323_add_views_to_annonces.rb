class AddViewsToAnnonces < ActiveRecord::Migration[5.2]
  def change
    add_column :annonces, :views, :integer, default: 0
  end
end
