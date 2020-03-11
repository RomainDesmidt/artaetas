class AddOeuvreoriginaleToAnnonces < ActiveRecord::Migration[5.2]
  def change
    add_column :annonces, :oeuvre_originale, :boolean
  end
end
