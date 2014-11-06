require  "terminfo"
require_relative "cell"

module Lifegame
  Coordinates = Struct.new(:y,:x)
  
  class Map
    attr_accessor :curr, :last
  
    DEFAULT_SIZE = Coordinates.new(*TermInfo.screen_size)
  
    def initialize(size = DEFAULT_SIZE)
      @last = []
      DEFAULT_SIZE.y.times do |_|
        @last << Array.new(DEFAULT_SIZE.x) { Cell.new([*0..1].sample) }
      end
      @size = size
      @curr = @last.map { |line| line.map(&:dup) }
    end
  
    def change_gen
      @last.each.with_index do |line, i|
        line.each.with_index do |_,j| 
          neighborsCount = get_neighbors_count(i, j)
          if neighborsCount == 3
            @curr[i][j].revive
          elsif ! neighborsCount.between?(2,3)
            @curr[i][j].kill
          end
          @curr[i][j].inc_age
        end
      end
  
      @last = @curr.map { |line| line.map(&:dup) }
    end

    def get_neighbors_count(pos_y, pos_x)
      pos_y == 0           ? (up    = @size.y - 1) : (up    = pos_y - 1)
      pos_y == @size.y - 1 ? (down  = 0)           : (down  = pos_y + 1)
      pos_x == @size.x - 1 ? (right = 0)           : (right = pos_x + 1)
      pos_x == 0           ? (left  = @size.x - 1) : (left  = pos_x - 1)
  
      return @last[up][left].stat    + @last[up][pos_x].stat    + @last[up][right].stat +
             @last[pos_y][left].stat + @last[pos_y][right].stat + 
             @last[down][left].stat  + @last[down][pos_x].stat  + @last[down][right].stat
    end
  
    def disp
      @curr.each do |line|
        puts line.map(&:view).join
      end
    end

  end
end
