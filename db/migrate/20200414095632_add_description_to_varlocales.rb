class AddDescriptionToVarlocales < ActiveRecord::Migration[5.2]
  def change
    add_column :varlocales, :description, :string
  end
end
