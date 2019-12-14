# frozen_string_literal: true

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'

  gem 'ruby2d'
  gem 'perlin_noise'
end

Point = Struct.new(:x, :y)

center = Point.new(150, 150)
radius = 100
n1d = Perlin::Noise.new 1

points = 0.upto(360).map do |degrees|
  radians = degrees * Math::PI / 180
  noise = 1 + n1d[radians] * 0.3
  Point.new(
    center.x + Math.cos(radians) * radius * noise,
    center.y + Math.sin(radians) * radius * noise
  )
end

(points + [points[0]]).each_cons(2) do |point1, point2|
  Line.new(
    x1: point1.x, y1: point1.y,
    x2: point2.x, y2: point2.y,
    width: 2,
    color: 'white'
  )
end

set(width: 300, height: 300)
show
