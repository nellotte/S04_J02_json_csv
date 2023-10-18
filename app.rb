require 'bundler'
Bundler.require

$:.unshift File.expand_path("./../lib", __FILE__)
require 'app/scrapper.rb'

def scrapping
  scrapper = Scrapper.new # Créez une instance de la classe Scrapper
  val_oise_hash = scrapper.perform # Récupérez le hash retourné par perform
  return val_oise_hash
end

def save_as_json
  val_oise_hash = scrapping
  File.open('db/email.json', 'w') do |f|
  f.write(val_oise_hash.to_json)
  end
end

def save_as_csv
  val_oise_hash = scrapping
  csv_file = File.join('db', 'email.csv')
  CSV.open("db/email.csv", "w") do |csv|
    csv << ['Name', 'Email']
    val_oise_hash.each do |name, email|
      csv << [name, email]
    end
  end
end

scrapping
save_as_json
save_as_csv




# val_oise_hash.each{|key,value| puts "#{key} : #{value}"}
