require "minitest/autorun"
require "stringio"

require "hitting_rock_bottom"

describe HittingRockBottom do
  let(:data_dir) {
    File.join(File.dirname(__FILE__), *%w[.. data])
  }
  let(:cave_path)     { File.join(data_dir, "simple_cave.txt") }
  let(:solution_path) { File.join(data_dir, "simple_out.txt")  }
  
  it "solves the simple cave example" do
    stdout, _ = capture_io do
      open(cave_path) do |simple_cave|
        HittingRockBottom.solve(simple_cave)
      end
    end
    stdout.must_equal(File.read(solution_path))
  end
  
  it "solves the simple cave edge case from the problem description" do
    stdout, _ = capture_io do
      simple_cave = File.read(cave_path)
      simple_cave.sub!(/\A100/, "45")
      HittingRockBottom.solve(StringIO.new(simple_cave))
    end
    stdout.must_equal( "1 2 2 4 4 4 4 6 6 6 1 1 1 1 ~ " +
                       "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0\n" )
  end
end
