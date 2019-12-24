# frozen_string_literal: true



class Canvas < MagickCanvas::Base
  RADIUS = 30

  attr_accessor :ball

  Ball = Struct.new(:x, :y, :speed_x, :speed_y, :direction_x, :direction_y)

  def initialize
    super
    self.ball = Ball.new(center.x, center.y, 6, 3, 1, 1)
  end

  def options
    {
      width: 300,
      height: 300,
      number_of_frames: 100
    }
  end

  def draw(image, frame_count)
    ball.x += ball.speed_x * ball.direction_x
    ball.y += ball.speed_y * ball.direction_y

    if ball.x < RADIUS || ball.x > width - RADIUS
      ball.direction_x *= -1
    end

    if ball.y < RADIUS || ball.y > height - RADIUS
      ball.direction_y *= -1
    end

    gc = Draw.new
    gc.stroke('white').stroke_width(1)
    gc.circle(ball.x, ball.y, ball.x - RADIUS, ball.y)
    gc.draw(image)
  end
end
