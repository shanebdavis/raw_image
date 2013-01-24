# encoding: BINARY

module RawImage
class Color
  include Colors

  attr_accessor :r, :g, :b, :a

  # 0 <= values <= 1
  def initialize(r=0, g=r, b=r, a=1.0)
    @r = r; @g = g; @b = b; @a = a
  end

  # 0 <= val <= 1
  def gray=(val)
    @r = @g = @b = g
  end
  alias :grey= :gray=

  def byte(int)
    "%c"%int
  end

  def inspect
    "color(#{[r,g,b,a].join(', ')})"
  end

  def to_s
    "#%02x%02x%02x%02x"%[r8,g8,b8,a8]
  end

  def r8; r * 255; end
  def g8; g * 255; end
  def b8; b * 255; end
  def a8; a * 255; end
  def gray8; g * 255; end
  alias :grey8 :gray8

  def gray; (r+g+b)/3; end
  alias :grey :gray

  def to_bytes(format)
    case format
    when :g8    then [byte(g8)].join
    when :rgb8  then [byte(r8), byte(g8), byte(b8)].join
    when :rgba8 then [byte(r8), byte(g8), byte(b8), byte(a8)].join
    end
  end
end
end
