require 'pry'

class KefotoScraper::CLI

    attr_accessor :kefoto_scraper

      def initialize
        site = "https://www.kefotos.mx/aficionado/"
        kefoto_scraper = Scraper.new(site)
        kefoto_scraper.get_products
      end

      def call
        puts "welcome to the Kefoto Scrapper CLI. To exit the program type 'exit' when prompt to answer a question. Enjoy!"
        main_menu
        end_flow
      end

      def main_menu
        puts "These are the services that Kefoto offers:"
        list_products
        answer = ""
        until answer.to_i.between?(1,6) == true
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
      end

      def end_flow
        answer = ""
        until answer == "yes" || answer == "exit" do
          puts "to return to the list of products type 'yes' or 'exit' to finish"
          answer = gets.chomp
        if answer == "exit"
          puts "Goodbye!"
          exit
        elsif answer != "yes" && answer != "exit"
          puts "You did not enter a valid entry. Please try again."
          elsif answer == "yes"
          main_menu
        end
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
        average_price = selected_product.price_range.reduce(:+).to_f / selected_product.price_range.size
        puts "The average price for #{selected_product.name} is #{average_price}"
        puts "The max price is $#{selected_product.price_range.max}"
        puts "The min price is $#{selected_product.price_range.min}"
      end

    end
