require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'term/ansicolor'

include Term::ANSIColor

class MealTime
  DAYS = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

  def self.get_naked_lunch
    puts 'Naked Lunch'.green.bold
    sandwiches = []
    html_body = get_nokogiri_object_from_url("http://sites.google.com/site/nakedlunchsf/")        
    [
      '//*[@id="sites-canvas-main-content"]/div/table/tbody/tr/td[2]/div/div/div[2]/div[5]/font/span/b',
      '//*[@id="sites-canvas-main-content"]/div/table/tbody/tr/td[2]/div/div/div[2]/div[9]/font/span/b',
      '//*[@id="sites-canvas-main-content"]/div/table/tbody/tr/td[2]/div/div/div[2]/div[13]/font/span/b',
      '//*[@id="sites-canvas-main-content"]/div/table/tbody/tr/td[2]/div/div/div[2]/div[17]/font/span/b'
    ].each do |sandwich_xpath|
      html_body.xpath(sandwich_xpath).each do |node|
        sandwiches << node.content.split("\302").first
      end
    end
    sandwiches.each {|sandwich| puts "  #{sandwich}"}
  end

  def self.get_cheeseboard
    puts "Cheeseboard".green.bold
    # The conditional is a weird way of finding whether its Monday through Saturday
    if (2..6).include?(Time.now.wday)
      pizzas = []
      html_body = get_nokogiri_object_from_url("http://cheeseboardcollective.coop/pizza")
      html_body.css("div.column")[0].css("p").each do |node|
        pizzas << node.content
      end
      pizzas.slice!(5..pizzas.length)
      puts "  #{DAYS[Time.now.wday]}".blue + ": #{pizzas[Time.now.wday-2]}"
    else
      puts "  Closed!".red
    end
  end

  def self.get_arizmendi
    puts "Arizmendi Bakery/Pizzeria".green.bold
    html_body = get_nokogiri_object_from_url("http://www.arizmendibakery.org/pizza")
    html_body.css("td.active p.yasp-item").each do |node|
      puts "  #{DAYS[Time.now.wday]}".blue + ": #{node.content}"
    end
  end

  def self.get_kasa
    locations = []
    puts "Kasa locations".green.bold
    html_body = get_nokogiri_object_from_url("http://kasaindian.com/indian-restaurant-sf/truck")
    html_body.css("#eme_list-3 ul li a").each do |node|
      locations << node.content
    end
    puts "  #{DAYS[Time.now.wday]}".blue + ": #{locations.first}"
  end

  private
  def self.get_nokogiri_object_from_url(url)
    html = open(url)
    doc = Nokogiri::HTML(html.read)
    doc
  end
end
