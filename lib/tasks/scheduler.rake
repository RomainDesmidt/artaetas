desc "This task is called by the Heroku scheduler add-on, should modify premium annonce to turn to standard if its subscription ended"
task :modify_annonce => :environment do
  old_name = Annonce.find(20).name
  new_name = old_name + "+"
  Annonce.find(20).update(name: new_name)
end

task :check_periode_malu => :environment do
  @periode_malu = Varlocale.where(nomchamp: "PeriodeMalu").first.valeurchamp
  Order.where(ongoing_subscription: true).where(premium_sku: "Mise a la une").each do |order|
    if order.updated_at < @periode_malu.days.ago
      order.update(ongoing_subscription: false)
      order.annonce.update(formule: "Standard")
    end
  end
end

task :check_periode_mea => :environment do
  @periode_mea = Varlocale.where(nomchamp: "PeriodeMea").first.valeurchamp
  Order.where(ongoing_subscription: true).where(premium_sku: "Mise en Avant").each do |order|
    if order.updated_at < @periode_mea.days.ago
      order.update(ongoing_subscription: false)
      order.annonce.update(formule: "Standard")
    end
  end
end