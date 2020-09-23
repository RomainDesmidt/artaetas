class CreateSponsorsTwo < ActiveRecord::Migration[5.2]
  def change
    create_table :sponsors do |t|
      t.string :name, default: ""
      t.text :texte, default: ""
      t.string :lien_image, default: ""
      t.string :lien_video, default: ""
      t.string :lien_redir, default: ""
      t.boolean :publiee, default: false
      t.integer :compteur, default: 0
      t.datetime :period_start, default: Time.now
      
      t.timestamps
    end
  end
end
