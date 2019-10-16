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
            product_url = Nokogiri::HTML(open(service_link))
            if link == "foto-enmarcada.php"
            @product_prices = product_url.css(".m-0").text.map {|price| /\d/}

            binding.pry
          end
      end


    #  def view_price_range
    #    price_range = []
    #    @service_links.each do |link|
    #    if @service = link
    # link.css(".row").map {|price| price["p"].value}
    #    price_range << p
    #     end
    #    price_range
    #  end

     # # TODO: read about ruby memoization
     # def home_node
     #
     #     @home_node ||=
     #      Nokogiri::HTML(PAGE_URL)
     # end


end
