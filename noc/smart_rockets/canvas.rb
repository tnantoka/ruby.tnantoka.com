# frozen_string_literal: true

# Daniel Shiffman
# http://natureofcode.com

# Smart Rockets w/ Genetic Algorithms

# Each Rocket's DNA is an array of PVectors
# Each PVector acts as a force for each frame of animation
# Imagine an booster on the end of the rocket that can point in any direction
# and fire at any strength every frame.  The Rocket's fitness is a function of
# how close it gets to the target as well as how fast it gets there
# This example is inspired by Jer Thorp's Smart Rockets
# http://www.blprnt.com/smartrockets/

require 'bundler/setup'
Bundler.require

require_relative '../../vec2d'
require_relative '../../helpers'

require_relative 'dna'
require_relative 'population'
require_relative 'rocket'
require_relative 'obstacle'

class Canvas < MagickCanvas::Base
  attr_accessor :rocket, :target, :mutation_rate, :lifetime,
                :life_counter, :population, :obstacles

  def initialize
    super
    self.lifetime = height
    self.life_counter = 0
    self.mutation_rate = 0.01
    init_objects
  end

  def options
    height = 360
    {
      width: 640,
      height: height,
      number_of_frames: height * 50,
      frame_steps: 10,
      iterations: 1
    }
  end

  def update(_frame_count)
    if life_counter < lifetime
      population.update(obstacles, target)
      self.life_counter += 1
    else
      self.life_counter = 0
      population.fitness
      population.selection
      population.reproduction
    end
  end

  def draw(image, _frame_count)
    gc = Draw.new

    draw_info(gc)
    target.draw(image)

    gc.draw(image)

    population.draw(image)
    obstacles.each { |o| o.draw(image) }
  end

  private

  # rubocop:disable Naming/MethodParameterName
  def draw_info(gc)
    gc.fill('white')
    gc.pointsize = 14
    gc.text(10, 18, "Generation #: #{population.generations}")
    gc.text(10, 36, "Cycles left: #{lifetime - life_counter}")
  end
  # rubocop:enable Naming/MethodParameterName

  def init_objects
    self.target = Obstacle.new(width / 2 - 12, 24, 24, 24)
    self.population = Population.new(mutation_rate, 50, width, height)
    self.obstacles = [Obstacle.new(width / 2 - 100, height / 2, 200, 10)]
  end
end
