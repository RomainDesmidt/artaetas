class CreateCategorieAnnonces < ActiveRecord::Migration[5.2]
  def change
    create_table :categorie_annonces do |t|
      t.references :categorie, foreign_key: true
      t.references :annonce, foreign_key: true

      t.timestamps
    end
  end
end
