  require 'pry'
  require 'rubygems'
  require 'open-uri'
  require 'nokogiri'
  require 'httparty'


    class KefotoScraper::CLI


      def initialize
      @page_url = "https://www.kefotos.mx/"
      @product_names = get_product_names()
      @price_range = []
      end

      def call
        puts "These are the services that Kefoto offers:"
        get_product_names
        list_products
        puts "Enter the number of the product you wish to inspect"
        @answer = gets.chomp
        puts "Selecting #{@answer}. #{@product_names[@answer.to_i-1]}"

        select_from_list
        price_array

        if @answer == "1"
          photo_enmarcada_price_range_cli
        else 
          price_cli 
        end
      end
    
    

      def get_html
        get_html ||=
        Nokogiri::HTML(HTTParty.get @page_url) 
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
        @product_url = Nokogiri::HTML(HTTParty.get @url)
      end

      def price_array

        @product_prices = @product_url.css(".container-fluid").text
        @prices = @product_prices.scan(/[\$£](\d{1,3}(,\d{3})*(\.\d*)?)/)
        @prices.each do |price| 
          @price_range << price[0]
        end
      end

      def photo_enmarcada_price_range_cli
          @price_range_size_dimension = @price_range.take(6)
          @price_range_frame_type = @price_range.drop(6)
          puts "These are the range of prices based on dimension:"
          puts "#{@price_range_size_dimension.first} - #{@price_range_size_dimension.last}"
          puts "#{@price_range_frame_type.first} - #{@price_range_frame_type.last}"
          puts "Would you like to see the uniq prices in the range for both of these? y/n"
          @answer_1 = gets.chomp

          if @answer_1 == "y"
          puts "Based on dimension:"
          puts @price_range_size_dimension.uniq
          puts "Based on frame type:"
          puts @price_range_frame_type.uniq
          main_menu

          elsif @answer_1 == "n"
          main_menu
        end

      end

      def price_cli
          puts "These are the range of prices"
          puts "#{@price_range.first} - #{@price_range.last}"
          puts "Would you like to see the uniq prices in the range for both of these? y/n"
          @answer_1 = gets.chomp

          if @answer_1 == "y"
              puts @price_range.uniq
              main_menu
          elsif @answer_1 == "n"
              main_menu
          end
      end

      
      def main_menu
          puts "Do you want to return to the main menu? y/n"
          @yn = gets.chomp
        if @yn ==  "y"
          call
        end
      end
    
    end




