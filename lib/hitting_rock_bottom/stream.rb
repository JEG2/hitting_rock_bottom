module HittingRockBottom
  class Stream
    def initialize(cave)
      @cave         = cave
      @head         = [0, 0]
      @units        = 0
      @backtracking = [ ]
      find_head
    end
    
    attr_reader :cave, :head, :units
    
    def fill(goal_units = @units + 1)
      while units < goal_units
        if down.open?
          down.fill
          flow_down
        elsif right.open?
          right.fill
          flow_right
        elsif can_backtrack? :open
          backtrack
          fill
        else
          break
        end
      end
    end
    
    private
    
    def find_head
      find_tail
      follow_water
    end
    
    def find_tail
      until current.water?
        flow_down
      end
    end
    
    def follow_water
      loop do
        if down.water?
          flow_down
        elsif right.water?
          flow_right
        elsif can_backtrack? :water
          backtrack
        else
          break
        end
      end
    end
    
    def current
      @cave[*@head]
    end
    
    def down
      @cave[@head[0], @head[1] + 1]
    end
    
    def right
      @cave[@head[0] + 1, @head[1]]
    end
    
    def flow_down
      if current.water? and not right.rock?
        @backtracking << @head.dup
      end
      @head[1] += 1
      count_units
    end
    
    def flow_right
      @head[0] += 1
      count_units
    end
    
    def count_units
      @units += 1 if current.water?
    end
    
    def can_backtrack?(to)
      not @backtracking.empty? and
      @cave[@backtracking.last[0] + 1, @backtracking.last[1]].send("#{to}?")
    end
    
    def backtrack
      @head = @backtracking.pop
    end
  end
end
