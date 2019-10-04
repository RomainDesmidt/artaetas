class CreateAnnonces < ActiveRecord::Migration[5.2]
  def change
    create_table :annonces do |t|
      t.boolean :envente_yesno
      t.string :name
      t.integer :anneecreation
      t.text :description
      t.decimal :prix
      t.string :format
      t.string :disposition
      t.string :nom_artiste
      t.references :user, foreign_key: true
      t.integer :user_id_artiste
      t.integer :hauteur
      t.integer :largeur
      t.integer :profondeur
      t.string :oeuvre_limite
      t.boolean :certificat_authenticite
      t.boolean :facture_achat
      t.boolean :encadrement
      t.boolean :etat_neuf

      t.timestamps
    end
  end
end
