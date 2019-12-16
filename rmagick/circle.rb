# frozen_string_literal: true

require 'bundler/setup'
Bundler.require
include Magick # rubocop:disable Style/MixinUsage

tmp = File.expand_path('../tmp', __dir__)
path = "#{tmp}/image.png"

image = Image.new(300, 300) { self.background_color = 'black' }

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

draw = Draw.new
draw.stroke('white').stroke_width(1)

draw.polygon(*points.flat_map { |p| [p.x, p.y] })

draw.draw(image)

image.write(path)
`open #{path}`
