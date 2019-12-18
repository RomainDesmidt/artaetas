class CreateVarlocales < ActiveRecord::Migration[5.2]
  def change
    create_table :varlocales do |t|
      t.string :nomchamp
      t.integer :valeurchamp

      t.timestamps
    end
  end
end
