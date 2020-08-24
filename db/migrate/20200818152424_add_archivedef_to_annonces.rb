class AddArchivedefToAnnonces < ActiveRecord::Migration[5.2]
  def change
    add_column :annonces, :archivedef, :boolean, default: false
  end
end
