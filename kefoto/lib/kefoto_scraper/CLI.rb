
  require 'pry'

  class KefotoScraper::CLI

    attr_accessor :kefoto_scraper

      def initialize
      site = "https://www.kefotos.mx/aficionado/"
      kefoto_scraper = Scraper.new(site)
      kefoto_scraper.get_products

      end

      def call
        puts "These are the services that Kefoto offers:"
        list_products
        puts "Enter the number of the product you wish to inspect"
        @index = gets.chomp
        select_from_list_cli
        call
      end


      def list_products
        Products.all.each_with_index do |product, i|

        puts "#{i+1} #{product.name}"
        end
      end

      def select_from_list_cli
          if @index.to_i.between?(1,6) == false
            puts "ERROR! You did not select a valid number from the list. Please try again."
          else
        selected_product = Products.all[@answer.to_i-1]
        puts "These are the prices for #{selected_product.name}:"
        puts "#{selected_product.price_range}"
        return_to_main_menu
        end
      end

      def return_to_main_menu
        puts "Would you like to inspect another product? for yes type 'y' for no type 'exit!"
          @answer= gets.chomp
            if @answer ==  "y"
              KefotoScraper::CLI.new.call
            else
              puts "ERROR!: Please enter 'y' for 'yes' or 'exit!' for 'no'."
            end
      end


    end
