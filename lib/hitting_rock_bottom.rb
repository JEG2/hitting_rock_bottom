require "hitting_rock_bottom/parser"
require "hitting_rock_bottom/stream"

module HittingRockBottom
  module_function
  
  def solve(input, output = $stdout)
    parser = Parser.new(input)
    Stream.new(parser.cave).fill(parser.units)
    output.puts parser.cave.depths
  end
end
