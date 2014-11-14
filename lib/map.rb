require_relative "cell"

module Lifegame
  Coordinates = Struct.new(:y,:x)
  
  class Map
    attr_accessor :curr, :last
    NEIGHBORS = [ [-1, -1], [-1, 0], [-1, 1],
                  [ 0, -1],          [ 0, 1],
                  [ 1, -1], [ 1, 0], [ 1, 1] ]
  
    def initialize(y, x)
      @last = []
      @size = Coordinates.new(y, x)
      @size.y.times do 
        @last << Array.new(@size.x) { Cell.new(rand(0..1)) }
      end
      @curr = @last.map { |line| line.map(&:dup) }
    end
  
    def change_gen
      @last.each_with_index do |line, i|
        line.each_index do |j| 

          neighbors_count = get_neighbors_count(i, j)
          if neighbors_count.between?(2,3)
            @curr[i][j].stat = 1 if neighbors_count == 3 
            @curr[i][j].inc_age
          else
            @curr[i][j].stat = 0
          end

        end
      end
  
      @last = @curr.map { |line| line.map(&:dup) }
    end

    def get_neighbors_count(y, x)
      NEIGHBORS.map do |dy,dx| 
        i = (y + dy) % @size.y
        j = (x + dx) % @size.x
        @last[i][j].stat 
      end.inject(:+)
    end

    def disp
      @curr.each do |line|
        puts line.map(&:to_s).join
      end
    end

  end
end
