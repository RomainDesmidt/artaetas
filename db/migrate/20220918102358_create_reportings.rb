class CreateReportings < ActiveRecord::Migration[5.2]
  def change
    create_table :reportings do |t|
      t.string :username
      t.integer :userid
      t.string :params
      t.string :origin
      
      t.timestamps
    end
  end
end
