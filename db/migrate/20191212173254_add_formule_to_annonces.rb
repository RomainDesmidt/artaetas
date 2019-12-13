class AddFormuleToAnnonces < ActiveRecord::Migration[5.2]
  def change
    add_column :annonces, :formule, :string
  end
end
