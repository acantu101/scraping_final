require 'pry'
require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'httparty'


  class KefotoScraper::CLI


    def initialize
    @product_names = get_product_names()
    @page_url = "https://kefotos.mx/"
    end


    def call
      puts "These are the services that Kefoto offers:"
      get_product_names
      list_products
      puts "Enter the number of the product you wish to inspect"
      @answer = gets.chomp
      puts "Selecting #{@answer}. #{@product_names[@answer.to_i-1]}"

      select_from_list

      view_price_range
      @price


    end


    def get_html
      HTTParty.get(@page_url)

    end


    def get_product_names
    get_html.css('.nav-link[href]').map { |l|
      l['href'].sub(/\.php$/, '')
    }
  end



    def list_products
        n = 1
        @product_names.each_with_index do |list_item, i|
          puts "#{n} #{list_item}"
          n+=1
        end
      end

      def select_from_list
         @service_links = get_html.css(".nav-link").map {|link| link['href']}
         @selection = @service_links[@answer.to_i-1]
         @url = @page_url.concat(@selection)

         @product_url = HTTParty.get(@url)

        end

      def view_price_range
        money_sign = "$"

        @product_prices = @product_url.css(".container-fluid").text
          @price = @product_prices.scan(/[\$£](\d{1,3}(,\d{3})*(\.\d*)?)/)
          @price
        end


end
