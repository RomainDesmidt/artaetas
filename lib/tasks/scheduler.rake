desc "This task is called by the Heroku scheduler add-on, should modify premium annonce to turn to standard if its subscription ended"
task :modify_annonce => :environment do
  old_name = Annonce.find(20).name
  new_name = old_name + "+"
  Annonce.find(20).update(name: new_name)
end

