class AddNametoCouleur < ActiveRecord::Migration[5.2]
  def change
    add_column :couleurs, :name, :string
  end
end
