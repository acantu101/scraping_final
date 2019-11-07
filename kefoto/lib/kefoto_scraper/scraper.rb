require 'pry'
class Scraper

  attr_accessor :url, :link, :price_range, :product

  def initialize(url)
      @url = url
  end

  def get_html
    get_html = Nokogiri::HTML(HTTParty.get url)
  end

   def scrape_products
     price_range = []
     products = get_html.css(".navbar-nav li")
     products.each do |product|
       name = product.css("span").text
       link = product.css("a").attr("href").value
       prices = Nokogiri::HTML(HTTParty.get link).text
       price_a = prices.scan(/[\$£](\d{1,3}(,\d{3})*(\.\d*)?)/)
        prices_a.each do |price|
            price_range << price_a[0]
          end
         @product = Products.new(name, link, price_range)

         @product = product
      end
    end



end
