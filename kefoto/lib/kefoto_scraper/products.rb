class Products

  attr_accessor :name, :link, :price_range

  @@all = []

  def initialize(name)
    @name = name
    @price_range = []
    save
  end


  def self.all
    @@all
  end

  def save
    @@all << self
  end



end
