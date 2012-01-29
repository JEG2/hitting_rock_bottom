module HittingRockBottom
  class Cave
    def initialize(cells)
      @cells = cells
    end
    
    def [](x, y)
      @cells[y] && @cells[y][x]
    end
    
    def depths
      @cells.transpose.map { |column|
        if column.each_cons(2).any? { |l, r| l.water? and r.open? }
          "~"
        else
          column.count(&:water?)
        end
      }.join(" ")
    end
  end
end
