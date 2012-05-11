require 'rubygems'
require 'nokogiri'
require 'open-uri'

class MealTime
  def self.get_naked_lunch
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
    sandwiches
  end

  private
  def self.get_nokogiri_object_from_url(url)
    html = open(url)
    doc = Nokogiri::HTML(html.read)
    doc
  end
end