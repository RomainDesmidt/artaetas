class CreateCouleurs < ActiveRecord::Migration[5.2]
  def change
    create_table :couleurs do |t|
      t.string :couleur_dominante

      t.timestamps
    end
  end
end
