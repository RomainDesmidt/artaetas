class AddUsernameToAdminUsers < ActiveRecord::Migration[5.2]
  def change
      change_table :admin_users do |t|
      t.string :username, null: false, default: ""
    end
  end
end
