# frozen_string_literal: true

# The Nature of Code
# Daniel Shiffman
# http://natureofcode.com

# DNA is an array of vectors
class DNA
  include Math
  MAX_FORCE = 0.1
  TWO_PI = PI * 2
  attr_accessor :genes, :lifetime

  def create_genes(lftm)
    self.genes = (0...lftm).map do
      angle = rand(TWO_PI)
      Vec2D.new(cos(angle), sin(angle)) * rand(0..MAX_FORCE)
    end
  end

  def initialize(lifetime, newgenes = nil)
    self.lifetime = lifetime
    self.genes = newgenes.nil? ? create_genes(lifetime) : newgenes.clone
  end

  def crossover(partner)
    child = Array.new(genes.length, Vec2D.new)
    crossover = rand(genes.length)
    genes.each_with_index do |gene, i|
      child[i] = i > crossover ? gene : partner.genes[i]
    end
    DNA.new(lifetime, child)
  end

  def mutate(mutation_rate)
    genes.length.times do |i|
      if rand < mutation_rate
        angle = rand(TWO_PI)
        genes[i] = Vec2D.new(cos(angle), sin(angle)) * rand(0..MAX_FORCE)
      end
    end
  end
end
