class AddDepartementToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :departement, :integer
  end
end
