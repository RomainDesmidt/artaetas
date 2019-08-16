# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_08_16_091018) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "annonces", force: :cascade do |t|
    t.boolean "envente_yesno"
    t.string "name"
    t.integer "anneecreation"
    t.text "description"
    t.decimal "prix"
    t.string "format"
    t.string "disposition"
    t.string "nom_artiste"
    t.bigint "user_id"
    t.integer "user_id_artiste"
    t.integer "hauteur"
    t.integer "largeur"
    t.integer "profondeur"
    t.boolean "oeuvre_unique"
    t.integer "oeuvre_limite"
    t.boolean "oeuvre_illimite"
    t.boolean "certificat_authenticite"
    t.boolean "facture_achat"
    t.boolean "encadrement"
    t.boolean "etat_neuf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
    t.string "photo_un"
    t.string "photo_deux"
    t.index ["user_id"], name: "index_annonces_on_user_id"
  end

  create_table "categorie_annonces", force: :cascade do |t|
    t.bigint "categorie_id"
    t.bigint "annonce_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["annonce_id"], name: "index_categorie_annonces_on_annonce_id"
    t.index ["categorie_id"], name: "index_categorie_annonces_on_categorie_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "couleur_annonces", force: :cascade do |t|
    t.bigint "couleur_id"
    t.bigint "annonce_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["annonce_id"], name: "index_couleur_annonces_on_annonce_id"
    t.index ["couleur_id"], name: "index_couleur_annonces_on_couleur_id"
  end

  create_table "couleurs", force: :cascade do |t|
    t.string "couleur_dominante"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courant_annonces", force: :cascade do |t|
    t.bigint "courant_id"
    t.bigint "annonce_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["annonce_id"], name: "index_courant_annonces_on_annonce_id"
    t.index ["courant_id"], name: "index_courant_annonces_on_courant_id"
  end

  create_table "courant_users", force: :cascade do |t|
    t.bigint "courant_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["courant_id"], name: "index_courant_users_on_courant_id"
    t.index ["user_id"], name: "index_courant_users_on_user_id"
  end

  create_table "courants", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.date "date"
    t.boolean "oeuvre_vendue"
    t.bigint "annonce_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["annonce_id"], name: "index_orders_on_annonce_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "surname"
    t.string "lastname"
    t.boolean "afficher_identite"
    t.boolean "afficher_email"
    t.string "tel"
    t.boolean "afficher_tel"
    t.string "paysresidence"
    t.string "villeresidence"
    t.integer "codepostal"
    t.string "instagram"
    t.string "facebook"
    t.string "website"
    t.text "description"
    t.boolean "masquefavoris"
    t.string "statut"
    t.boolean "masquepublication"
    t.integer "nbvue_profil"
    t.boolean "confirmation_webmaster"
    t.string "photoprofil"
    t.string "photofond"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", id: :serial, force: :cascade do |t|
    t.string "votable_type"
    t.integer "votable_id"
    t.string "voter_type"
    t.integer "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  end

  add_foreign_key "annonces", "users"
  add_foreign_key "categorie_annonces", "annonces"
  add_foreign_key "categorie_annonces", "categories", column: "categorie_id"
  add_foreign_key "couleur_annonces", "annonces"
  add_foreign_key "couleur_annonces", "couleurs"
  add_foreign_key "courant_annonces", "annonces"
  add_foreign_key "courant_annonces", "courants"
  add_foreign_key "courant_users", "courants"
  add_foreign_key "courant_users", "users"
  add_foreign_key "orders", "annonces"
  add_foreign_key "orders", "users"
end
