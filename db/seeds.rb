# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Cleaning database..."
CategorieAnnonce.destroy_all
CouleurAnnonce.destroy_all
CourantAnnonce.destroy_all
# Annonce.destroy_all
Categorie.destroy_all
# User.destroy_all
Courant.destroy_all
Couleur.destroy_all

puts "Creating Categories"

Categorie.new(name: "Peinture").save
Categorie.new(name: "Sculpture").save
Categorie.new(name: "Photographie").save
Categorie.new(name: "Editions").save
Categorie.new(name: "Dessins").save
Categorie.new(name: "Gravures et estampes").save
Categorie.new(name: "Medias mixtes").save


puts "Creating Courants"

Courant.new(name: "Abstrait").save
Courant.new(name: "Nature").save
Courant.new(name: "Nus").save
Courant.new(name: "Scenes de vie").save
Courant.new(name: "Nature morte").save
Courant.new(name: "Classique").save
Courant.new(name: "Ville").save
Courant.new(name: "Street Art").save
Courant.new(name: "Pop Art").save
Courant.new(name: "Portraits").save
Courant.new(name: "Animaux").save
Courant.new(name: "Art moderne").save
Courant.new(name: "Noir et blanc").save
Courant.new(name: "Aquarelle").save
Courant.new(name: "Icones").save
Courant.new(name: "Collage et art papier").save
Courant.new(name: "Art numerique").save
Courant.new(name: "Calligraphie").save
Courant.new(name: "Art brut").save
Courant.new(name: "Art deco").save
Courant.new(name: "Art nouveau").save

puts "Couleurs dominante"

Couleur.new(couleur_dominante: "Bleu").save
Couleur.new(couleur_dominante: "Blanc").save
Couleur.new(couleur_dominante: "Gris").save
Couleur.new(couleur_dominante: "Jaune").save
Couleur.new(couleur_dominante: "Marron").save
Couleur.new(couleur_dominante: "Noir").save
Couleur.new(couleur_dominante: "Orange").save
Couleur.new(couleur_dominante: "Rose").save
Couleur.new(couleur_dominante: "Rouge").save
Couleur.new(couleur_dominante: "Vert").save
Couleur.new(couleur_dominante: "Violet").save


# puts "Creating courant...."
# baroque = Courant.create!(
# name: "baroque",
# description: "Le baroque est un courant artistique qui utilise exagérément le mouvement et la grandeur, avec exubérance."
# )

# cubisme = Courant.create!(
# name: "cubisme",
# description: "les œuvres cubistes représentent des objets analysés, décomposés et réassemblés en une composition abstraite."
# )



# puts "creating users..."
# leonard = User.create!(
#   surname: "leonard",
#   email: "leonard@medicis.it",
#   password: "123456",
#   password_confirmation: "123456",
#   courant_users: [
#   CourantUser.new(
#     courant: baroque
#   )
#  ]
# )
# leonard.save!

# camille = User.create!(
#   surname: "camille",
#   email: "camille@gmail.com",
#   password: "123456",
#   password_confirmation: "123456"
# )
# camille.save!

# puts "Creating categories..."
# tribal = Categorie.create!(
# name: "tribal",
# description: "lorem ipsum tribal"

# )

# moderne = Categorie.create!(
# name: "moderne",
# description: "recent moins de 50 ans"
# )

# puts "Creating couleurs..."
# red = Couleur.create!(
# couleur_dominante: "red"
# )

# magenta = Couleur.create!(
# couleur_dominante: "magenta"
# )


# puts "Creating annonce...."
# annonce_1 = Annonce.create!(
# name: "La Joconde",
# user: camille,
# nom_artiste: "leonard",
# # user_id_artiste: User.first.id,
# description: "produite par leonard de vinci",
#   categorie_annonces: [
#     CategorieAnnonce.new(
#       categorie: tribal
#     ),

#     CategorieAnnonce.new(
#       categorie: moderne
#     )
#    ],
#  couleur_annonces: [
#   CouleurAnnonce.new(
#     couleur: red
#   ),

#   CouleurAnnonce.new(
#     couleur: magenta
#   )
#  ],
#  courant_annonces: [
#   CourantAnnonce.new(
#     courant: cubisme
#   ),

#   CourantAnnonce.new(
#     courant: baroque
#   )
#  ]
# )

# # puts annonce_1.nom_artiste
# # puts User.where(name: 'leonard').first.id
# annonce_1.user_id_artiste = User.where(surname: annonce_1.nom_artiste).first.id
# annonce_1.save!


AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?