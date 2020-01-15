class Products

  attr_accessor :name, :price_range

  @@all = []

  def initialize(name, price_range)
    @name = name
    @price_range = price_range
    save
  end


  def self.all
    @@all
  end

  def save
    if @@all.include?(self) == false
    @@all << self
    end
  end


end
