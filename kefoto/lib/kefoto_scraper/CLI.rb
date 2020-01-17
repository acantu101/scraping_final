
  require 'pry'

  class KefotoScraper::CLI

    attr_accessor :kefoto_scraper

      def initialize
      site = "https://www.kefotos.mx/aficionado/"
      kefoto_scraper = Scraper.new(site)
      kefoto_scraper.get_products
      end
#index and answer should be the same thing
#while loop in program

      def call
        puts "welcome to the Kefoto Scrapper CLI. To exit the program type 'exit' when prompt to answer a question. Enjoy!"
        main_menu
        end_flow
      end

      def main_menu
        puts "These are the services that Kefoto offers:"
        list_products
        puts "Enter the index of the product to see it's prices."
        answer = gets.chomp
        if answer == "exit"
          puts "Goodbye!"
          exit
        elsif answer.to_i.between?(1,6) == false
          puts "You entered an invalid number. Please enter a valid number to continue."
        else
        select_from_list_cli(answer)
        end_flow
      end
    end

      def end_flow
        puts "to return to the list of products type 'yes' or 'exit' to finish"
        answer = gets.chomp
        if answer == "exit"
          puts "Goodbye!"
          exit
        elsif answer != "yes" && answer != "exit"
          puts "You did not enter a valid entry"
          answer = gets.chomp
          elsif answer == "yes"
          main_menu

    end
  end

      def list_products
        Products.all.each_with_index do |product, i|
          puts "#{i+1} #{product.name}"
        end
      end

      def select_from_list_cli(answer)
        selected_product = Products.all[answer.to_i-1]
        puts "These are the prices for #{selected_product.name}:"
        puts "#{selected_product.price_range}"
      end

    end
