  require 'pry'

  class KefotoScraper::CLI

attr_accessor :url

      def initialize
        url = "https://www.kefotos.mx/"
        Scraper.new(url).scrape_products
      end


      def call
        puts "These are the services that Kefoto offers:"
        list_products
        select_from_list_cli
        main_menu
      end


      def list_products
        Products.all.each_with_index do |product, i|
        puts "#{i+1} #{product.name}"
        end
      end

      def select_from_list_cli
        puts "Enter the number of the product you wish to inspect"
        answer = gets.chomp
          if answer.to_i.between?(1,6) == false
            puts "ERROR! You did not select a valid number from the list. Please try again."
          else
        selected_product = Products.all[answer.to_i-1]
        puts "Selecting #{selected_product.name}"
        puts "These is the price range for #{selected_product.name}:"
        puts "#{selected_product.price_range}"
        end
      end

      def main_menu
        puts "To return to main menu enter 'y'"
          @yn = gets.chomp
            if @yn ==  "y"
              KefotoScraper::CLI.new.call
            else
              puts "ERROR!: Please enter 'y' to return to main menu."
            end
      end


    end
