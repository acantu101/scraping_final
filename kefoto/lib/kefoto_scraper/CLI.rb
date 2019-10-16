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
    list_products
    end

    # puts "which service would you like to select?"
    # @selection = gets.chomp
    # view_price_range
    # puts "Would you like to go back to the service menu? y/n"
    # answer = gets.chomp
    #   if answer == "y"
    #   call
    #   end

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
      @product_names
    end


def list_products
    n = 1
    @product_names.each_with_index do |list_item, i|
      puts "#{n} #{list_item}"
      n+=1
    end
  end


       #  i = 1
       #  n = 1
       # while n < @product_names.length
       #    item = @product_names[n]
       #    puts "#{i}). #{item}"
       #   i += 1
       #   n += 1
       #  end
       # end


      def service_links
          @service_links ||=
          home_html.css(".nav-item").map { |link| link['href'] }
      end

     # def view_price_range
     #   price_range = []
     #   @service_links.each do |link|
     #     if @service = link
     #       link.css(".row").map {|price| price["p"].value}
     #        price_range << p
     #     end
     #     price_range
     # end

     # # TODO: read about ruby memoization
     # def home_node
     #
     #     @home_node ||=
     #      Nokogiri::HTML(PAGE_URL)
     # end


end
