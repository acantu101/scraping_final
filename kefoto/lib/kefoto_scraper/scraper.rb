
require 'httparty'
require 'open-uri'
require 'net/http'
require 'pry'

class Scraper

  attr_accessor :site, :content, :price_range


  def initialize(site)
      @site = site
      doc = HTTParty.get(site)
      @parse_page ||= Nokogiri::HTML(doc)
      @price_range = [].uniq
  end

  def get_products
    @content = @parse_page.css(".container-fluid")
    @content.each do |product|
    @name = product.css("a").attr("href").text
    @link = @site + @name
    get_price_range
    new_product = Products.new(@name, @price_range)
  end
  @name
  end

  def reset_link
  @link.clear
  end

  def get_price_range
    get_products
    Nokogiri::HTML(open(@link)).content.scan(/[\$£](\d{1,3}(,\d{3})*(\.\d*)?)/).each do |price|
         if @price_range.include?(price[0]) == false
          @price_range << price[0]
         end
    end
  end

    def new_product
      get_products
      puts new_product
    end

  end
