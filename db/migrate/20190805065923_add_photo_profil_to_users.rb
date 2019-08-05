class AddPhotoProfilToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :photoprofil, :string
  end
end
