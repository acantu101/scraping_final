require 'pry'
require 'rubygems'
require 'open-uri'
require 'nokogiri'


  class KefotoScraper::CLI


    def initialize
    @product_names = []
    @page_url = "https://kefotos.mx/"
    end


    def call
      puts "These are the services that Kefoto offers:"
      service_names
      list_products

      puts "Enter the number of the product you wish to inspect"
      @answer = gets.chomp
      select
      view_price_range


    end


    def home_html
        Nokogiri::HTML(open(@page_url))
    end

    def service_names
        @service_names = home_html.css(".nav-link").map do
          |link| link['href'].to_s.gsub(/.php/, "")
        end
      @service_names.each do |pr|
      @product_names << pr
        end
      end


    def list_products
        n = 1
        @product_names.each_with_index do |list_item, i|
          puts "#{n} #{list_item}"
          n+=1
        end
      end

      def select
        @product_array = home_html.css(".nav-link").map {|link| link['href']}
         @service_links = home_html.css(".nav-link").map {|link| link['href']}
         @selection = @service_links[@answer.to_i-1]
         @url = @page_url.concat(@selection)
         @product_url = Nokogiri::HTML(open(@url))

        end
  
      def view_price_range
        money_sign = "$"

        if @selection == "foto-enmarcada.php"
        

          @product_prices = @product_url.css(".m-0").text
          prices_array = @product_prices.split(":")
          money = prices_array.match /[$]\d......./

          cleaner_price_array = money.match /\d/

          final_price_array = cleaner_price_array.map {|price| money_sign.concat(price)}
       
          final_price_array
          end
        end
     
  


end


