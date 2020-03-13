class RemoveOeuvreoriginaleFromAnnonce < ActiveRecord::Migration[5.2]
  def change
    remove_column :annonces, :oeuvre_originale
  end
end
