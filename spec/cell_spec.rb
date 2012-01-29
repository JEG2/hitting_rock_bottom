require "minitest/autorun"

require "hitting_rock_bottom/cell"

describe HittingRockBottom::Cell do
  MAPPING = {rock: "#", open: " ", water: "~"}
  
  def cell(*args)
    HittingRockBottom::Cell.new(*args)
  end
  
  it "knows its type by symbol" do
    MAPPING.each do |name, symbol|
      cell = cell(symbol)
      cell.send("#{name}?").must_equal(true)
      MAPPING.each do |other_name, other_symbol|
        next if symbol == other_symbol
        cell.send("#{other_name}?").must_equal(false)
      end
    end
  end
  
  it "allows the filling of open cells" do
    cell = cell(" ")
    cell.fill
    cell.water?.must_equal(true)
    cell.open?.must_equal(false)
  end
  
  it "fails with an error if you try to fill a non-open cell" do
    (MAPPING.values - [" "]).each do |symbol|
      lambda { cell(symbol).fill }.must_raise(RuntimeError)
    end
  end
end
