#!/usr/bin/env ruby

require  "pry"
require  "terminfo"

SELF_DIR = File.expand_path("../", __FILE__)
Dir["#{SELF_DIR}/lib/*.rb"].each { |lib| require_relative lib }

size = Lifegame::Coordinates.new(*TermInfo.screen_size)
size.y -= 1

m = Lifegame::Map.new(size.y, size.x)

loop do
  system "clear"
  m.disp
  sleep 0.15
  m.change_gen
end
