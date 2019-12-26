class RenameFormatToVolume < ActiveRecord::Migration[5.2]
  def change
    rename_column :annonces, :format, :volume
  end
end
