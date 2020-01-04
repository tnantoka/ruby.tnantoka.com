# frozen_string_literal: true

# The Nature of Code
# Daniel Shiffman
# http://natureofcode.com
# Pathfinding w/ Genetic Algorithms

# A class to describe a population of "creatures"
class Population
  attr_accessor :mutation_rate, :population, :mating_pool,
                :generations, :width, :height, :target

  def initialize(mutation_rate, num, width, height, target)
    self.mutation_rate = mutation_rate
    self.width = width
    self.height = height
    self.target = target
    self.mating_pool = []
    self.generations = 0
    self.population = Array.new(num) do
      Rocket.new(Vec2D.new(width / 2, height + 20), DNA.new(height), target)
    end
  end

  def update
    population.each(&:update)
  end

  def draw(image)
    population.each { |rocket| rocket.draw(image) }
  end

  def fitness
    population.each(&:fitness)
  end

  def selection
    mating_pool.clear
    max_fit = max_fitness

    population.each do |pop|
      probability(max_fit, pop.fitness).times { mating_pool << pop }
    end
  end

  def reproduction
    population.length.times do |i|
      child = crossover
      population[i] = Rocket.new(
        Vec2D.new(width / 2, height + 20),
        child,
        target
      )
    end
    self.generations += 1
  end

  def max_fitness
    population.max_by(&:fitness).fitness
  end

  private

  def probability(max_fit, fitness)
    fitness_normal = map1d(fitness, (0..max_fit), (0..1))
    (fitness_normal * 100).to_i
  end

  def crossover
    momgenes = random_genes
    dadgenes = random_genes

    child = momgenes.crossover(dadgenes)
    child.mutate(mutation_rate)
    child
  end

  def random_genes
    mating_pool[rand(mating_pool.length)].dna
  end
end
