# frozen_string_literal: true

class Canvas < MagickCanvas::Base
  attr_accessor :ball

  Ball = Struct.new(
    :radius, :x, :y, :speed_x, :speed_y, :direction_x, :direction_y
  ) do
    def dx
      speed_x * direction_x
    end

    def dy
      speed_y * direction_y
    end

    def left
      x - radius
    end

    def overflow_x?(width)
      x < radius || x > width - radius
    end

    def overflow_y?(height)
      y < radius || y > height - radius
    end

    def turn_x(width)
      self.direction_x *= -1 if overflow_x?(width)
    end

    def turn_y(height)
      self.direction_y *= -1 if overflow_y?(height)
    end
  end

  def initialize
    super
    self.ball = Ball.new(30, center.x, center.y, 6, 3, 1, 1)
  end

  def options
    {
      width: 300,
      height: 300,
      number_of_frames: 100
    }
  end

  def update(_frame_count)
    ball.x += ball.dx
    ball.y += ball.dy

    ball.turn_x(width)
    ball.turn_y(height)
  end

  def draw(image, _frame_count)
    gc = Draw.new
    gc.stroke('white').stroke_width(1)
    gc.circle(ball.x, ball.y, ball.left, ball.y)
    gc.draw(image)
  end
end
