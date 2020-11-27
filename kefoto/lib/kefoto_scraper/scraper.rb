
require 'httparty'
require 'open-uri'
require 'net/http'
require 'pry'

class Scraper

  attr_accessor :site, :content, :name, :price_range

  def initialize(site)
    
      @site = site
      doc = HTTParty.get(site)
      @parse_page ||= Nokogiri::HTML(doc)
	  get_price
	  @price_range = @costo.uniq.sort!
	  get_products 
	  @name = new_product.name
	  @price_range = new_product_price_range

  end

  def get_products
    content = @parse_page.css(".nav-item")
    content.each do |product|
      @name = product.css("span").text
      @url = product.css("a").attr("href").text
      @link = @site + @url
      get_price
      new_product = Products.new(@name, @price_range)
      
    end
    new_product
  end

  def get_price
    @costo = []
    prices = Nokogiri::HTML(open(@link)).content.scan(/[\$£](\d{1,3}(,\d{3})*(\.\d*)?)/).each do |price|
      @costo << price[0].to_i
      end
	end



  end
