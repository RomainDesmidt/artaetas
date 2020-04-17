class AddLastordersubToAnnonces < ActiveRecord::Migration[5.2]
  def change
    add_column :annonces, :last_sub_order, :string
  end
end
