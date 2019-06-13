class ChangeUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
     t.string :surname
     t.string :lastname
     t.boolean :afficher_identite
     t.boolean :afficher_email
     t.string :tel
     t.boolean :afficher_tel
     t.string :paysresidence
     t.string :villeresidence
     t.integer :codepostal
     t.string :instagram
     t.string :facebook
     t.string :website
     t.text :description
     t.boolean :masquefavoris
     t.string :statut
     t.boolean :masquepublication
     t.integer :nbvue_profil
     t.boolean :confirmation_webmaster
    end
  end
end
