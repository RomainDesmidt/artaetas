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
Annonce.destroy_all
Categorie.destroy_all
User.destroy_all
Courant.destroy_all
Couleur.destroy_all

puts "Creating courant...."
baroque = Courant.create!(
name: "baroque",
description: "Le baroque est un courant artistique qui utilise exagérément le mouvement et la grandeur, avec exubérance."
)

cubisme = Courant.create!(
name: "cubisme",
description: "les œuvres cubistes représentent des objets analysés, décomposés et réassemblés en une composition abstraite."
)



puts "creating users..."
leonard = User.create!(
  surname: "leonard",
  email: "leonard@medicis.it",
  password: "123456",
  password_confirmation: "123456",
  courant_users: [
  CourantUser.new(
    courant: baroque
  )
 ]
)
leonard.save!

camille = User.create!(
  surname: "camille",
  email: "camille@gmail.com",
  password: "123456",
  password_confirmation: "123456"
)
camille.save!

puts "Creating categories..."
tribal = Categorie.create!(
name: "tribal",
description: "lorem ipsum tribal"

)

moderne = Categorie.create!(
name: "moderne",
description: "recent moins de 50 ans"
)

puts "Creating couleurs..."
red = Couleur.create!(
couleur_dominante: "red"
)

magenta = Couleur.create!(
couleur_dominante: "magenta"
)


puts "Creating annonce...."
annonce_1 = Annonce.create!(
name: "La Joconde",
user: camille,
nom_artiste: "leonard",
# user_id_artiste: User.first.id,
description: "produite par leonard de vinci",
  categorie_annonces: [
    CategorieAnnonce.new(
      categorie: tribal
    ),

    CategorieAnnonce.new(
      categorie: moderne
    )
   ],
 couleur_annonces: [
  CouleurAnnonce.new(
    couleur: red
  ),

  CouleurAnnonce.new(
    couleur: magenta
  )
 ],
 courant_annonces: [
  CourantAnnonce.new(
    courant: cubisme
  ),

  CourantAnnonce.new(
    courant: baroque
  )
 ]
)

# puts annonce_1.nom_artiste
# puts User.where(name: 'leonard').first.id
annonce_1.user_id_artiste = User.where(surname: annonce_1.nom_artiste).first.id
annonce_1.save!


