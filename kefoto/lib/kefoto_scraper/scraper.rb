
require 'httparty'
require 'open-uri'

class Scraper

  attr_accessor :doc, :product_names, :site, :name, :link


  def initialize
    @price_range = [].uniq
  end


  def scrape_page(site)
    @site = site
    doc = Nokogiri::HTML(open (site))
    content = doc.css(".nav-item li")
    content
  end

  def name
   scrape_page(site).each do |product|
      @name = product.css("span").text
      @name
     end
   end

   def link
    scrape_page(site).each do |product|
      plink = product.css("a").attr("href").text
      @link = site.concat(plink)
      @link 
    end
  end

  def price_range
    prices = Nokogiri::HTML(open (link))
    pr = prices.scan(/[\$£](\d{1,3}(,\d{3})*(\.\d*)?)/)
    prices = pr.text
      prices.each do |price|
         if @price_range.include?(price[0]) == false
          @price_range << price[0]
         end
         @price_range = price_range
         price_range
      end
    end


    def create_new_product
    new_product = Products.new(name, price_range)
    puts new_product
    end

  end
