# frozen_string_literal: true

require 'bundler/setup'
Bundler.require

class Canvas < MagickCanvas::Base
  attr_accessor :ball, :space, :circle_body

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
    self.space = CP::Space.new
    space.gravity = CP::Vec2.new(0, 300)
    add_ball
    add_wall(0, height - 1, width, height)
    add_wall(width - 1, 0, width, height)
  end

  def options
    {
      width: 300,
      height: 300,
      number_of_frames: 100
    }
  end

  def update(_frame_count)
    space.step(1.0 / 30)
    ball.x = circle_body.p.x
    ball.y = circle_body.p.y
  end

  def draw(image, _frame_count)
    gc = Draw.new
    gc.stroke('white').stroke_width(1)
    gc.circle(ball.x, ball.y, ball.left, ball.y)
    gc.draw(image)
  end

  private

  def add_ball
    self.ball = Ball.new(30, center.x, center.y, 6, 3, 1, 1)
    body = init_ball_body(ball)
    shape = init_ball_shape(ball, body)
    space.add_body(body)
    space.add_shape(shape)
    self.circle_body = body
  end

  def init_ball_body(ball)
    CP::Body.new(10, CP::INFINITY).tap do |body|
      body.p = CP::Vec2.new(ball.x, ball.y)
      body.v = CP::Vec2.new(100, 300)
    end
  end

  def init_ball_shape(ball, body)
    CP::Shape::Circle.new(body, ball.radius, CP::Vec2.new(0, 0)).tap do |shape|
      shape.e = 0.8
    end
  end

  def add_wall(x1, y1, x2, y2) # rubocop:disable Naming/MethodParameterName
    body = CP::Body.new_static
    verts = [
      CP::Vec2.new(x1, y1),
      CP::Vec2.new(x1, y2),
      CP::Vec2.new(x2, y2),
      CP::Vec2.new(x2, y1)
    ]
    shape = CP::Shape::Poly.new(body, verts, CP::Vec2.new(0, 0))
    shape.e = 0.6
    space.add_shape(shape)
  end
end
