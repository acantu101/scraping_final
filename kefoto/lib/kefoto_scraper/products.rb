class Products

  attr_accessor :name, :link

  @@all = []

  def initialize(name, link, price_range)
    @name = name
    @link = link
    @price_range = price_range
    save
  end

  def self.all
    @@all
  end

  def save
   @@all.each do |product|
     if product != self
        @@all << self
      end
    end
  end




end
