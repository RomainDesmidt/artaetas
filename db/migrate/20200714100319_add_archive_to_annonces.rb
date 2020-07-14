class AddArchiveToAnnonces < ActiveRecord::Migration[5.2]
  def change
    add_column :annonces, :archive, :boolean, default: false
  end
end
