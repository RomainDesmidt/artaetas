class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.integer :follower_id
      t.integer :followee_id

      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
