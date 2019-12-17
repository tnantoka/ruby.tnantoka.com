# frozen_string_literal: true

require 'bundler/setup'
Bundler.require

class Canvas
  include Magick

  Point = Struct.new(:x, :y)

  PATH = "#{File.expand_path('../tmp', __dir__)}/image.gif"
  RADIUS = 100
  FREQUENCY = 10
  SIZE = 300

  attr_accessor :image_list, :center

  def initialize
    self.image_list = Magick::ImageList.new
    self.center = Point.new(SIZE * 0.5, SIZE * 0.5)
  end

  def open
    draw
    write
    `open -a Safari #{PATH}`
  end

  private

  def draw
    range = (-15..15).to_a
    (range + range.reverse).each do |amplitude|
      image = image_list.new_image(SIZE, SIZE) { self.background_color = 'black' }
      draw_polygon(image, points(amplitude))
    end
  end

  def write
    image_list.write(PATH)
  end

  def points(amplitude)
    (0..360).map do |degrees|
      radians = degrees * Math::PI / 180
      noise = Math.sin(radians * FREQUENCY) * amplitude
      noised_point(radians, noise)
    end
  end

  def noised_point(radians, noise)
    Point.new(
      center.x + Math.cos(radians) * (RADIUS + noise),
      center.y + Math.sin(radians) * (RADIUS + noise)
    )
  end

  def draw_polygon(image, points)
    gc = Draw.new
    gc.stroke('white').stroke_width(1)
    gc.polygon(*points.flat_map { |p| [p.x, p.y] })
    gc.draw(image)
  end
end

Canvas.new.open
