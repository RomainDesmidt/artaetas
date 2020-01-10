class AddConfirmCguCompteurRappelToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :confirm_cgu, :boolean
    add_column :users, :compteur_rappel, :integer
  end
end
