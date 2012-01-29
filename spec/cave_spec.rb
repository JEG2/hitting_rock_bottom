require "minitest/autorun"

require "hitting_rock_bottom/cave"

describe HittingRockBottom::Cave do
  def cave(*args)
    HittingRockBottom::Cave.new(*args)
  end
  
  def stub(type)
    Object.new.tap do |object|
      object.singleton_class.instance_eval do
        %w[water rock open].each do |query|
          define_method("#{query}?") do
            query == type.to_s
          end
        end
      end
    end
  end
  
  it "allows access to contents by coordinates" do
    cave = cave( [ ["#", "#", "#"],
                   ["~", " ", "#"],
                   ["#", "#", "#"] ] )
    cave[0, 0].must_equal("#")
    cave[0, 1].must_equal("~")
    cave[1, 1].must_equal(" ")
  end
  
  it "can calculate the water depth of each column" do
    water = stub(:water)
    rock  = stub(:rock)
    cave( [ [rock,  rock,  rock,  rock],
            [water, water, rock,  rock],
            [rock,  water, water, rock],
            [rock,  water, water, rock],
            [rock,  rock,  rock,  rock] ] ).depths.must_equal("1 3 2 0")
  end
  
  it "shows falling water depths as a tilde" do
    water = stub(:water)
    rock  = stub(:rock)
    open  = stub(:open)
    cave( [ [rock,  rock,  rock,  rock],
            [water, water, open,  rock],
            [rock,  water, open,  rock],
            [rock,  open,  open,  rock],
            [rock,  rock,  rock,  rock] ] ).depths.must_equal("1 ~ 0 0")
  end
end
