#!/usr/bin/env ruby

require  "pry"

SELF_DIR = File.expand_path("../", __FILE__)
Dir["#{SELF_DIR}/lib/*.rb"].each { |lib| require_relative lib }

m = Lifegame::Map.new

loop do
  system "clear"
  m.disp
  sleep 0.15
  m.change_gen
end
