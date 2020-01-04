# frozen_string_literal: true

# https://github.com/ruby-processing/JRubyArt/blob/361a8b5cb5476b96037d016b30565a883a6861be/src/main/java/monkstone/vecmath/vec2/Vec2.java
class Vec2D
  attr_accessor :x, :y

  EPSILON = 9.999999747378752e-05

  def initialize(*args)
    case args.size
    when 1
      init_with_object(object)
    when 2
      init_with_points(args)
    else
      init_with_defaults
    end
  end

  def init_with_object(object)
    self.x = object.x
    self.y = object.y
  rescue NoMethodError
    raise TypeError
  end

  def init_with_points(points)
    self.x = points[0]
    self.y = points[1]
  end

  def init_with_defaults
    self.x = 0
    self.y = 0
  end

  def ==(other)
    (x - other.x).abs < EPSILON && (y - other.y).abs < EPSILON
  end

  def +(other)
    Vec2D.new(x + other.x, y + other.y)
  end

  def *(other)
    Vec2D.new(x * other, y * other)
  end

  def dist(other)
    Math.hypot(x - other.x, y - other.y)
  end

  def copy
    Vec2D.new(x, y)
  end

  def to_a
    [x, y]
  end

  def heading
    Math.atan2(y, x)
  end
end
