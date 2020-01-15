
require 'httparty'
require 'open-uri'
require 'net/http'
require 'pry'

class Scraper

  attr_accessor :site, :content, :name, :price_range

@@all = []

  def initialize(site)
      @site = site
      doc = HTTParty.get(site)
      @parse_page ||= Nokogiri::HTML(doc)

  end

  def get_products
    @content = @parse_page.css(".nav-item")
    @content.each do |product|
      @name = product.css("a").attr("href").text
      @link = @site + @name
      get_price
      Products.new(@name, @price_range)
    end
  end

  def save
    if @@all.include?(self) == false
      @@all << self
    end
  end

  def get_price
    @costo = []
    prices = Nokogiri::HTML(open(@link)).content.scan(/[\$£](\d{1,3}(,\d{3})*(\.\d*)?)/).each do |price|
      @costo << price[0]
      end
    @price_range = @costo.uniq
    @price_range
    end




  end
