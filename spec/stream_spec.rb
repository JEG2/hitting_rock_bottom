require "minitest/autorun"
require "stringio"

require "hitting_rock_bottom/parser"
require "hitting_rock_bottom/stream"

describe HittingRockBottom::Stream do
  def stream(cave, units = 42)
    io     = StringIO.new("#{units}\n\n#{cave}".gsub(/^[ \t]+/, ""))
    parser = HittingRockBottom::Parser.new(io)
    HittingRockBottom::Stream.new(parser.cave)
  end
  
  it "knows where the head of the stream is" do
    stream(<<-END_CAVE).head.must_equal([0, 1])
    ###
    ~ #
    ###
    END_CAVE
  
    stream(<<-END_CAVE).head.must_equal([1, 1])
    ###
    ~~#
    ###
    END_CAVE
  end
  
  it "counts units as it moves over water" do
    stream(<<-END_CAVE).units.must_equal(1)
    ###
    ~ #
    ###
    END_CAVE
  
    stream(<<-END_CAVE).units.must_equal(2)
    ###
    ~~#
    ###
    END_CAVE
  end
  
  it "fills in water going down when possible" do
    stream(<<-END_CAVE).tap(&:fill).cave[1, 2].water?.must_equal(true)
    ###
    ~~#
    # #
    ###
    END_CAVE
  end
  
  it "fills in water going right when it must" do
    stream(<<-END_CAVE).tap(&:fill).cave[1, 1].water?.must_equal(true)
    ###
    ~ #
    # #
    ###
    END_CAVE
  end
  
  it "backtracks when filling as needed" do
    stream(<<-END_CAVE).tap(&:fill).cave[2, 1].water?.must_equal(true)
    ####
    ~~ #
    #~~#
    ####
    END_CAVE
  end
  
  it "fill can repeat for a number of units" do
    stream = stream(<<-END_CAVE)
    ####
    ~  #
    #  #
    #  #
    ####
    END_CAVE
    stream.fill(7)
    1.upto(2) do |x|
      1.upto(3) do |y|
        stream.cave[x, y].water?.must_equal(true)
      end
    end
  end
end
