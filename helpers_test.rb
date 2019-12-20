# frozen_string_literal: true

require 'test-unit'

require './helpers'

# rubocop:disable Metrics/LineLength
class TestAdd < Test::Unit::TestCase
  # https://github.com/ruby-processing/JRubyArt/blob/8a293287fbec77faf3e8bfef5394b9df4b048dec/test/test_map1d.rb#L15
  def test_map1d
    x = [0, 5, 7.5, 10]
    range1 = (0..10)
    range2 = (100..1)
    range3 = (0..10)
    range4 = (5..105)
    assert_equal(map1d(x[0], range1, range2), 100, 'map to first')
    assert_equal(map1d(x[1], range1, range2), 50.5, 'map to reversed intermediate')
    assert_equal(map1d(x[2], range3, range4), 80.0, 'map to intermediate')
    assert_equal(map1d(x[3], range1, range2), 1, 'map to last')
  end

  # https://github.com/ruby-processing/JRubyArt/blob/8a293287fbec77faf3e8bfef5394b9df4b048dec/test/test_map1d.rb#L27
  def test_p5map # rubocop:disable Metrics/AbcSize
    x = [0, 5, 7.5, 10]
    range1 = (0..10)
    range2 = (100..1)
    range3 = (0..10)
    range4 = (5..105)
    assert_equal(p5map(x[0], range1.first, range1.last, range2.first, range2.last), 100)
    assert_equal(p5map(x[1], range1.first, range1.last, range2.first, range2.last), 50.5)
    assert_equal(p5map(x[2], range3.first, range3.last, range4.first, range4.last), 80.0)
    assert_equal(p5map(x[3], range1.first, range1.last, range2.first, range2.last), 1)
  end
end
# rubocop:enable Metrics/LineLength
