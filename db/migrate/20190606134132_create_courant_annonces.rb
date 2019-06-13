class CreateCourantAnnonces < ActiveRecord::Migration[5.2]
  def change
    create_table :courant_annonces do |t|
      t.references :courant, foreign_key: true
      t.references :annonce, foreign_key: true

      t.timestamps
    end
  end
end
