
class Scraper

  attr_accessor :url, :links, :price_range, :product

  def initialize
      @url = "https://www.kefotos.mx/"
      @links = []
      get_html
      get_product_link
      @product_price = product_price
      scrape_products
  end

  def get_html
    get_html = Nokogiri::HTML(HTTParty.get @url)
    get_html
  end

  def get_product_link
    prices_array = get_html.css(".navbar-nav li")
    prices_array.each do |product|
      link = product.css("a").attr("href").value
      @link_p = @url.concat(link)
    end
  end 

    def open_product_link
    open_product_link = Nokogiri::HTML(HTTParty.get @link_p).text
    open_product_link 
  end

  
  def product_price
    price_range = []
    prices = open_product_link.scan(/[\$£](\d{1,3}(,\d{3})*(\.\d*)?)/)
    prices.each do |price|
      if price_range.include?(price[0]) == false
      price_range << price[0]
      end
    @price_range = price_range
    price_range
    end
  end

   def scrape_products
     products = get_html.css(".navbar-nav li")
     products.each do |product|
       name = product.css("span").text
       link = product.css("a").attr("href").value
         @product = Products.new(name, link, product_price)
       end
       @product = product
       product
    end

end
