class AddPhotoFondToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :photofond, :string
  end
end
