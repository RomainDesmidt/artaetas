class AddPhotoToAnnonces < ActiveRecord::Migration[5.2]
  def change
    add_column :annonces, :photo, :string
    # add_column :annonces, :photo, :string, array: true, default: []
  end
end
