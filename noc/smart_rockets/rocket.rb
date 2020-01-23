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
                :target, :gene_counter, :hit_target, :stopped,
                :finish_time, :record_dist

  def initialize(location, dna)
    self.location = location.dup
    self.dna = dna
    self.acceleration = Vec2D.new
    self.velocity = Vec2D.new
    self.r = 5
    self.finish_time = 0
    self.record_dist = 10_000
    self.gene_counter = 0
    self.hit_target = false
    self.stopped = false
  end

  def update(obstacles)
    return if stopped || hit_target

    update_gene

    update_location
    obstacles(obstacles)
  end

  def draw(image)
    return if stopped

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
    self.record_dist = 1 if record_dist < 1
    f = (1 / (finish_time * record_dist))
    f **= 4
    f *= 0.1 if stopped
    f *= 2 if hit_target
    f
  end

  def check_target(target)
    d = location.dist(target.location)
    self.record_dist = d if d < record_dist

    if target.contains(location) && !hit_target
      self.hit_target = true
    elsif !hit_target
      self.finish_time += 1
    end
  end

  private

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

  def update_gene
    apply_force(dna.genes[gene_counter])
    self.gene_counter = (gene_counter + 1) % dna.genes.length
  end

  def update_location
    @velocity += acceleration
    @location += velocity
    @acceleration *= 0
  end

  def obstacles(obstacles)
    obstacles.each { |o| self.stopped = true if o.contains(location) }
  end
end
