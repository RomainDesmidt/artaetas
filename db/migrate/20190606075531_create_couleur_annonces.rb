class CreateCouleurAnnonces < ActiveRecord::Migration[5.2]
  def change
    create_table :couleur_annonces do |t|
      t.references :couleur, foreign_key: true
      t.references :annonce, foreign_key: true

      t.timestamps
    end
  end
end
