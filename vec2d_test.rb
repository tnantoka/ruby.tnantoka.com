# frozen_string_literal: true

require 'test-unit'

require_relative 'vec2d'

# https://github.com/ruby-processing/JRubyArt/blob/361a8b5cb5476b96037d016b30565a883a6861be/test/vecmath_spec_test.rb
# rubocop:disable Lint/UnreachableCode, Metrics/ClassLength, Metrics/LineLength
class TestVec2D < Test::Unit::TestCase
  Point = Struct.new(:x, :y)
  Pointless = Struct.new(:a, :b)

  def setup; end

  def test_equals
    x = 1.0000001
    y = 1.01
    a = Vec2D.new(x, y)
    assert_equal(a.to_a, [x, y], 'Failed to return Vec2D as an Array')
  end

  def test_not_equals
    a = Vec2D.new(3, 5)
    b = Vec2D.new(6, 7)
    refute_equal(a, b, 'Failed equals false')
  end

  def test_copy_equals
    x = 1.0000001
    y = 1.01
    a = Vec2D.new(x, y)
    b = a.copy
    assert_equal(a.to_a, b.to_a, 'Failed deep copy')
  end

  def test_constructor_float
    val = Point.new(1.0, 8.0)
    expected = Vec2D.new(val)
    assert_equal(expected, Vec2D.new(1.0, 8.0), 'Failed duck type constructor floats')
  end

  def test_constructor_fixnum
    val = Point.new(1, 8)
    expected = Vec2D.new(val)
    assert_equal(expected, Vec2D.new(1.0, 8.0), 'Failed duck type constructor fixnum')
  end

  def test_failed_duck_type
    val = Pointless.new(1.0, 8.0)
    assert_raises TypeError do
      Vec2D.new(val)
    end
  end

  def test_copy_not_equals
    x = 1.0000001
    y = 1.01
    a = Vec2D.new(x, y)
    b = a.copy
    b *= 0
    refute_equal(a.to_a, b.to_a, 'Failed deep copy')
  end

  def test_equals_when_close
    a = Vec2D.new(3.0000000, 5.00000)
    b = Vec2D.new(3.0000000, 5.000001)
    assert_equal(a, b, 'Failed to return equal when v. close')
  end

  def test_sum
    a = Vec2D.new(3, 5)
    b = Vec2D.new(6, 7)
    c = Vec2D.new(9, 12)
    assert_equal(a + b, c, 'Failed to sum vectors')
  end

  def test_subtract
    return
    a = Vec2D.new(3, 5)
    b = Vec2D.new(6, 7)
    c = Vec2D.new(-3, -2)
    assert_equal(a - b, c, 'Failed to subtract vectors')
  end

  def test_multiply
    a = Vec2D.new(3, 5)
    b = 2
    c = a * b
    d = Vec2D.new(6, 10)
    assert_equal(c, d, 'Failed to multiply vector by scalar')
  end

  def test_divide
    return
    a = Vec2D.new(3, 5)
    b = 2
    c = Vec2D.new(1.5, 2.5)
    d = a / b
    assert_equal(c, d, 'Failed to divide vector by scalar')
  end

  def test_dot
    return
    a = Vec2D.new(3, 5)
    b = Vec2D.new(6, 7)
    assert_in_epsilon(a.dot(b), 53, 0.001, 'Failed to dot product')
  end

  def test_self_dot
    return
    a = Vec2D.new(3, 5)
    assert_in_epsilon(a.dot(a), 34, 0.001, 'Failed self dot product')
  end

  def test_from_angle
    return
    a = Vec2D.from_angle(Math::PI * 0.75)
    assert_equal(a, Vec2D.new(-1 * Math.sqrt(0.5), Math.sqrt(0.5)), 'Failed to create vector from angle')
  end

  def test_random
    return
    a = Vec2D.random
    assert a.is_a? Vec2D
    assert_in_epsilon(a.mag, 1.0)
  end

  def test_assign_value
    a = Vec2D.new(3, 5)
    a.x = 23
    assert_equal(a.x, 23, 'Failed to assign x value')
  end

  def test_mag
    return
    a = Vec2D.new(-3, -4)
    assert_in_epsilon(a.mag, 5, 0.001, 'Failed to return magnitude of vector')
  end

  def test_mag_variant
    return
    a = Vec2D.new(3.0, 2)
    b = Math.sqrt(3.0**2 + 2**2)
    assert_in_epsilon(a.mag, b, 0.001, 'Failed to return magnitude of vector')
  end

  def test_mag_zero_one
    return
    a = Vec2D.new(-1, 0)
    assert_in_epsilon(a.mag, 1, 0.001, 'Failed to return magnitude of vector')
  end

  def test_dist
    a = Vec2D.new(3, 5)
    b = Vec2D.new(6, 7)
    assert_in_epsilon(a.dist(b), Math.sqrt(3.0**2 + 2**2), 0.001, 'Failed to return distance between two vectors')
  end

  def test_lerp
    return
    a = Vec2D.new(1, 1)
    b = Vec2D.new(3, 3)
    assert_equal(a.lerp(b, 0.5), Vec2D.new(2, 2), 'Failed to return lerp between two vectors')
  end

  def test_lerp_unclamped
    return
    a = Vec2D.new(1, 1)
    b = Vec2D.new(3, 3)
    assert_equal(a.lerp(b, 5), Vec2D.new(11, 11), 'Failed to return lerp between two vectors')
  end

  def test_lerp!
    return
    a = Vec2D.new(1, 1)
    b = Vec2D.new(3, 3)
    a.lerp!(b, 0.5)
    assert_equal(a, Vec2D.new(2, 2), 'Failed to return lerp! between two vectors')
  end

  def test_lerp_unclamped!
    return
    a = Vec2D.new(1, 1)
    b = Vec2D.new(3, 3)
    a.lerp!(b, 5)
    assert_equal(a, Vec2D.new(11, 11), 'Failed to return lerp! between two vectors')
  end

  def test_set_mag
    return
    a = Vec2D.new(1, 1)
    assert_equal(a.set_mag(Math.sqrt(32)), Vec2D.new(4, 4), 'Failed to set_mag vector')
  end

  def test_set_mag_block
    return
    a = Vec2D.new(1, 1)
    assert_equal(a.set_mag(Math.sqrt(32)) { true }, Vec2D.new(4, 4), 'Failed to set_mag_block true vector')
  end

  def test_set_mag_block_false
    return
    a = Vec2D.new(1, 1)
    assert_equal(a.set_mag(Math.sqrt(32)) { false }, Vec2D.new(1, 1), 'Failed to set_mag_block true vector')
  end

  def test_plus_assign
    a = Vec2D.new(3, 5)
    b = Vec2D.new(6, 7)
    a += b
    assert_equal(a, Vec2D.new(9, 12), 'Failed to += assign')
  end

  def test_normalize
    return
    a = Vec2D.new(3, 5)
    b = a.normalize
    assert_in_epsilon(b.mag, 1, 0.001, 'Failed to return a normalized vector')
  end

  def test_normalize!
    return
    a = Vec2D.new(3, 5)
    a.normalize!
    assert_in_epsilon(a.mag, 1, 0.001, 'Failed to return a normalized! vector')
  end

  def test_heading
    a = Vec2D.new(1, 1)
    assert_in_epsilon(a.heading, Math::PI / 4.0, 0.001, 'Failed to return heading in radians')
  end

  def test_rotate
    return
    x = 20
    y = 10
    b = Vec2D.new(x, y)
    a = b.rotate(Math::PI / 2)
    assert_equal(a, Vec2D.new(-10, 20), 'Failed to rotate vector by scalar radians')
  end

  def test_hash_index
    return
    x = 10
    y = 20
    b = Vec2D.new(x, y)
    assert_equal(b[:x], x, 'Failed to hash index')
  end

  def test_hash_set
    return
    x = 10
    b = Vec2D.new
    b[:x] = x
    assert_equal(b, Vec2D.new(x, 0), 'Failed to hash assign')
  end

  def test_inspect
    return
    a = Vec2D.new(3, 2.000000000000001)
    assert_equal(a.inspect, 'Vec2D(x = 3.0000, y = 2.0000)')
  end

  def test_array_reduce
    return
    array = [Vec2D.new(1, 2), Vec2D.new(10, 2), Vec2D.new(1, 2)]
    sum = array.reduce(Vec2D.new) { |c, d| c + d }
    assert_equal(sum, Vec2D.new(12, 6))
  end

  def test_array_zip # rubocop:disable Metrics/AbcSize
    return
    one = [Vec2D.new(1, 2), Vec2D.new(10, 2), Vec2D.new(1, 2)]
    two = [Vec2D.new(1, 2), Vec2D.new(10, 2), Vec2D.new(1, 2)]
    zipped = one.zip(two).flatten
    expected = [Vec2D.new(1, 2), Vec2D.new(1, 2), Vec2D.new(10, 2), Vec2D.new(10, 2), Vec2D.new(1, 2), Vec2D.new(1, 2)]
    assert_equal(zipped, expected)
  end

  def test_cross_area
    return
    a = Vec2D.new(200, 0)
    b = Vec2D.new(0, 200)
    assert_equal(a.cross(b).abs, 40_000.0, 'Failed area test using 2D vector cross product')
  end

  def test_cross_non_zero
    return
    a = Vec2D.new(40, 40)
    b = Vec2D.new(40, 140)
    c = Vec2D.new(140, 40)
    assert_equal((a - b).cross(b - c).abs / 2, 5_000.0, 'Failed area calculation using 2D vector cross product')
  end

  def test_cross_zero
    return
    a = Vec2D.new(0, 0)
    b = Vec2D.new(100, 100)
    c = Vec2D.new(200, 200)
    assert((a - b).cross(b - c).zero?, 'Failed collinearity test using 2D vector cross product')
  end
end
# rubocop:enable Lint/UnreachableCode, Metrics/ClassLength, Metrics/LineLength
