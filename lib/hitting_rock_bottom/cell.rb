module HittingRockBottom
  class Cell
    def initialize(symbol)
      @symbol = symbol
    end
    
    def rock?
      @symbol == "#"
    end
    
    def open?
      @symbol == " "
    end
    
    def water?
      @symbol == "~"
    end
    
    def fill
      fail "Only open cells can be filled with water" unless open?
      @symbol = "~"
    end
  end
end
