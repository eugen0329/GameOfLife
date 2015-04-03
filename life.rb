#!/usr/bin/env ruby

require  'terminfo'

SELF_DIR = File.expand_path('../', __FILE__)
DEFAULT_REFRESH_RATE = 0.11
Dir["#{SELF_DIR}/lib/*.rb"].each { |lib| require_relative lib }

size = Lifegame::Coordinates.new(*TermInfo.screen_size)
size.y -= 1         # to prevent wrong displaying when tmux panel isn't hidden

refresh_rate = ARGV.empty? ? DEFAULT_REFRESH_RATE : ARGV.shift.to_f

m = Lifegame::Map.new(size.y, size.x)

loop do
  system 'clear'
  m.disp
  sleep refresh_rate
  m.change_gen
end
