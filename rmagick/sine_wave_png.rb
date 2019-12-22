# frozen_string_literal: true

class Canvas < MagickCanvas::Base
  AMPLITUDE = 50
  FREQUENCY = 5

  def options
    {
      directory: File.expand_path('../tmp', __dir__),
      width: 400,
      height: 200
    }
  end

  def draw(image, _frame_count)
    points = (0..width).flat_map do |x|
      [
        x,
        center.y + Math.sin(radians(x) * FREQUENCY) * AMPLITUDE
      ]
    end

    gc = Draw.new
    gc.stroke('white').stroke_width(1)
    gc.polyline(*points)
    gc.draw(image)
  end
end
