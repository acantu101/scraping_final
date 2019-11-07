
class Scraper

  attr_accessor :doc, :product_names, :site, :name, :link


  def initialize(site)
    @site = site
    @doc = doc
    @product_names = product_names
    @name = name
    @link = link
    @price_range = [].uniq
    scrape_product
  end

  def get_html
    @doc = Nokogiri::HTML(open(@site))
    @product_names = doc.css(".navbar-nav li")
    product_names
  end

  def scrape_product
    get_html.each {|product|
      @name = product.css("span").text
      plink = product.css("a").attr("href").text
      @link = "#{site}#{link}"
      link_doc = Nokogiri::HTML(open(@link))
      pr = link_doc.scan(/[\$£](\d{1,3}(,\d{3})*(\.\d*)?)/)
      prices = pr_link.text
        prices.each {|price|
          if @price_range.include?(price[0]) == false
            @price_range << price[0]
            end
        }

      new_product = Products.new(@name, @price_range)
      puts new_product
  }
  end

end
