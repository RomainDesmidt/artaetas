class AddPhotoXToAnnonces < ActiveRecord::Migration[5.2]
  def change
    add_column :annonces, :photo_un, :string
    add_column :annonces, :photo_deux, :string
  end
end
