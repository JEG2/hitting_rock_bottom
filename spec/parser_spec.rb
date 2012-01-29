require "minitest/autorun"
require "stringio"

require "hitting_rock_bottom/parser"

describe HittingRockBottom::Parser do
  let(:units)  { 42 }
  let(:io)     { StringIO.new(<<-END_INPUT.gsub(/^[ \t]+/, "")) }
  #{units}
  
  ######
  ~    #
  # ## #
  ######
  END_INPUT
  let(:parser) { HittingRockBottom::Parser.new(io) }
  
  it "reads the units number from the beginning of the stream" do
    parser.units.must_equal(units)
  end
  
  it "reads the cave with cell contents" do
    parser.cave.must_be_instance_of(HittingRockBottom::Cave)
    parser.cave[0, 0].must_be_instance_of(HittingRockBottom::Cell)
  end
  
  it "arranges the cells to match the coordinates from the stream" do
    parser.cave[0, 1].water?.must_equal(true)
    parser.cave[1, 2].open?.must_equal(true)
    parser.cave[2, 2].rock?.must_equal(true)
  end
end
