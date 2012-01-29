require "hitting_rock_bottom/cell"
require "hitting_rock_bottom/cave"

module HittingRockBottom
  class Parser
    def initialize(io)
      @units = io.gets.to_i
      cave   = [ ]
      io.each do |line|
        next unless line =~ /\S/  # skip blank lines
        cave << [ ]
        line.scan(/./) { |cell| cave.last << Cell.new(cell) }
      end
      @cave  = Cave.new(cave)
    end
    
    attr_reader :units, :cave
  end
end
