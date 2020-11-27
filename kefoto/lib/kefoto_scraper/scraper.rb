
require 'httparty'
require 'net/http'
require 'pry'

class Scraper

  attr_accessor :site, :content, :name, :price_range

  def initialize(site)
    get_price
    @price_range = @costo.uniq.sort!
      @site = site
      doc = HTTParty.get(site)
      @parse_page ||= Nokogiri::HTML(doc)

  end

  def get_products
    content = @parse_page.css(".nav-item")
    content.each do |product|
      @name = product.css("span").text
      @url = product.css("a").attr("href").text
      @link = @site + @url
      get_price
      new_product = Products.new(@name, @price_range)
      new_product
    end
    content
  end

  def get_price
    @costo = []
    prices = Nokogiri::HTML(open(@link)).content.scan(/[\$£](\d{1,3}(,\d{3})*(\.\d*)?)/).each do |price|
      @costo << price[0].to_i
      end
	end


binding.pry

  end
