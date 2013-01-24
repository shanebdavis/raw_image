module RawImage
module Colors
  def black; Color.new(0.0); end
  def white; Color.new(1.0); end
  def gray; Color.new(0.5); end
  alias :grey :gray

  def transparent; Color.new(0, 0, 0, 0); end
end
end
