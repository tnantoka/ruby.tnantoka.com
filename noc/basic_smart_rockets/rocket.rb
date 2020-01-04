# frozen_string_literal: true

# The Nature of Code
# Daniel Shiffman
# http://natureofcode.com

# Pathfinding w/ Genetic Algorithms

# Rocket class -- this is just like our Boid / Particle class
# the only difference is that it has DNA & fitness
class Rocket
  include Magick

  attr_accessor :location, :velocity, :acceleration, :r, :dna,
                :target, :gene_counter, :hit_target

  def initialize(location, dna, target)
    self.location = location.dup
    self.dna = dna
    self.target = target
    self.acceleration = Vec2D.new
    self.velocity = Vec2D.new
    self.r = 10
    self.gene_counter = 0
    self.hit_target = false
  end

  def update
    check_target
    return if hit_target

    apply_force(dna.genes[gene_counter])
    self.gene_counter = (gene_counter + 1) % dna.genes.length

    update_location
  end

  def draw(image)
    gc = Draw.new

    gc.push
    gc.translate(location.x, location.y)

    rotate(gc)
    draw_origin(gc)

    draw_body(gc)
    draw_thrusters(gc)

    gc.pop

    gc.draw(image)
  end

  def fitness
    d = location.dist(target)
    (1 / d)**2
  end

  private

  def check_target
    self.hit_target = location.dist(target) < 12
  end

  # rubocop:disable Naming/MethodParameterName
  def apply_force(f)
    self.acceleration += f
  end

  def rotate(gc)
    theta = velocity.heading + Math::PI / 2
    gc.rotate(theta * 180 / Math::PI)
  end

  def draw_origin(gc)
    gc.fill('red')
    gc.circle(0, 0, -1, 0)
  end

  def draw_body(gc)
    gc.stroke('white')
    gc.fill('none')

    gc.polygon(
      0, -r * 2,
      -r, r * 2,
      r, r * 2
    )
  end

  def draw_thrusters(gc)
    gc.stroke('white')
    gc.fill('none')

    size = r * 0.5
    draw_thruster(gc, -r * 0.75, size)
    draw_thruster(gc, r * 0.25, size)
  end

  def draw_thruster(gc, x, size)
    gc.rectangle(
      x, r * 2,
      x + size, r * 2 + size
    )
  end
  # rubocop:enable Naming/MethodParameterName

  def update_location
    @velocity += acceleration
    @location += velocity
    @acceleration *= 0
  end
end
