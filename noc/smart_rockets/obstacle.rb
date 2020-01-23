# frozen_string_literal: true

# A class for an obstacle, just a simple rectangle that is drawn
# and can check if a Rocket touches it
# Also using this class for target location
class Obstacle
  include Magick

  attr_accessor :location, :width, :height

  # rubocop:disable Naming/MethodParameterName
  def initialize(x, y, width, height)
    self.location = Vec2D.new(x, y)
    self.width = width
    self.height = height
  end
  # rubocop:enable Naming/MethodParameterName

  def draw(image)
    gc = Draw.new

    draw_body(gc)

    gc.draw(image)
  end

  def contains(spot)
    contains_x?(spot) && contains_y?(spot)
  end

  private

  # rubocop:disable Naming/MethodParameterName
  def draw_body(gc)
    gc.stroke('white')
    gc.fill('lightgray')

    gc.rectangle(
      location.x, location.y,
      location.x + width, location.y + height
    )
  end
  # rubocop:enable Naming/MethodParameterName

  def contains_x?(spot)
    (location.x..location.x + width).include?(spot.x)
  end

  def contains_y?(spot)
    (location.y..location.y + height).include?(spot.y)
  end
end
