class AddSlugToAnnonces < ActiveRecord::Migration[5.2]
  def change
    add_column :annonces, :slug, :string
    add_index :annonces, :slug, unique: true
  end
end
