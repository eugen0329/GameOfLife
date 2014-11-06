require  "colorize"

module Lifegame
  class Cell
    attr_reader :stat
  
    COLOR_ORDER = %w{light_white white light_cyan cyan light_blue blue light_green 
                     green light_yellow yellow light_magenta magenta light_red red}.map(&:to_sym)
  
    def initialize(status = 0, age = 0)
      @stat = status
      @age  = age
    end
  
    def view
      @stat == 1 ? "▪".colorize(COLOR_ORDER[@age]) : " "
    end
  
    def inc_age
      @age += 1 
    end
  
    def revive
      @stat = 1  
    end
  
    def kill 
      @stat = 0
      @age  = 0
    end
  end
end
