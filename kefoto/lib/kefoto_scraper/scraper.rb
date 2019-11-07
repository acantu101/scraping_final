
class Scraper

  attr_accessor :url, :name, :link, :price_range, :new_product

  def initialize(url)
      @url = url
      @price_range = [].sort!
  end


  def get_html
    get_html = Nokogiri::HTML(HTTParty.get url)
  end

  def open_product_link
    open_product_link = Nokogiri::HTML(HTTParty.get link)
  end

  def scrape_product
    products = get_html.css(".navbar-nav li")
    products.each do |product|
      name = product.css("span").text
      Products.new(name)
    end
   end

  # def get_product_link
  #   products = get_html.css(".navbar-nav li")
  #   products.each do |product|
  #   plink = product.css("a").attr("href").value
  #   @link = plink.to_s
  #   @link = "#{url}#{link}"
  #   @link = link
  #   @@all << link
  # end 

  
  # def scrape_price
  #   prices = open_product_link.text
  #   pr = prices.scan(/[\$£](\d{1,3}(,\d{3})*(\.\d*)?)/)
  #   pr.each do |price|
  #     if @price_range.include?(price[0]) == false
  #     @price_range << price[0]
  #   @price_range = price_range
  #   @@all << price_range
  #   end
  # end

    def create_new_product
         Products.new(name)
    end

end
