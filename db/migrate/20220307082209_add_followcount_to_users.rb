class AddFollowcountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :followcount, :integer, default: 0
  end
end
