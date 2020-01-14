
require 'httparty'
require 'open-uri'
require 'net/http'
require 'pry'

class Scraper

  attr_accessor :site, :content, :price_range


  def initialize(site)
      @site = site
      doc = Nokogiri::HTML(Net::HTTP.get(URI(site)))
      @content = doc.css(".nav-item li")
      @price_range = [].uniq
  end


    def get_link
    @link = []
    @content.each do |product|
    @plink = product.css("a").attr("href").text
    link << @site.concat(@plink)
    end
    @link.to_s
  end

  def reset_link
  @link.clear
  end

  def get_price_range

    p_l = Nokogiri::HTML(Net::HTTP.get(URI(get_link))
    pr = prices.scan(/[\$£](\d{1,3}(,\d{3})*(\.\d*)?)/).text
    pr.each do |price|
         if @price_range.include?(price[0]) == false
          @price_range << price[0]
         end
    end
  end


    def create_new_product
      get_name
      get_link
      get_price_range
      new_product = Products.new(@name, @price_range)
      puts new_product
    end

  end
