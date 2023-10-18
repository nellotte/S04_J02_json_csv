require 'rubygems'
require 'nokogiri'
require 'open-uri'

#les adresses e-mails des mairies du Val d'Oise

def val_oise_city_list #pour générer mes urls personnalisé
  page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))

  scrapping_url_cities = page.xpath('//a[contains(@href, "./95/")]')
  url_city_array = []
  scrapping_url_cities.each do |element|
    url_city_array << element["href"].sub(/^\./, '') # pour supprimer le premier point avant "/95/"
  end
  #puts url_city_array
  return url_city_array
end

def get_townhall_name(val_oise_city_list)
  name_array = []
  val_oise_city_list.each do |city_name|
    
    page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com#{city_name}"))
    scrapping_per_city = page.xpath('/html/body/div[1]/main/section[1]/div/div/div/p[1]/strong[1]/a')

    scrapping_per_city.each do |name|
      name_array << name.text
    end
  end
  #puts name_array
  return name_array
end

def get_townhall_email(val_oise_city_list)
  emails_array = []
  val_oise_city_list.each do |city_url|
    
    page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com#{city_url}"))
    scrapping_per_city = page.xpath('//td[contains(text(), "@")]')

    scrapping_per_city.each do |email|
      emails_array << email.text
    end
  end
  #puts emails_array
  return emails_array
end

def perform(array_1,array_2)
  val_oise_hash = Hash[array_1.zip(array_2)]
  val_oise_hash.each{|key,value| puts "#{key} : #{value}"}
end

perform(get_townhall_name(val_oise_city_list),get_townhall_email(val_oise_city_list))