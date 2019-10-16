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
          binding.pry
      puts "Enter the number of the product you wish to inspect"
      @answer = gets.chomp


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

      def service_links

          @service_links = home_html.css(".nav-link").map {|link| link['href']}
            @service_links.each do |link|
            service_link =  @page_url.concat(link)
            @product_url = Nokogiri::HTML(open(service_link))

          end
      end

      def view_price_range
        money_sign = "$"
        if link == "foto-enmarcada.php"
          @product_prices = product_url.css(".m-0").text
          prices_array = @product_prices.split(":")
          clean_price_array = prices_array.map { |price| price.match /[$]\d......./}
          cleaner_price_array = clean_price_array.map { |price| price.match /\d/}
          final_price_array= cleaner_price_array.map { |price| money_sign.concat(price)}
    
          
      end




end
