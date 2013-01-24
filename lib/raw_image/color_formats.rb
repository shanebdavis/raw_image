module RawImage
# legal image formats and info about each format
def self.color_formats
  {
  :g8 => {:byte_size => 1, :bit_size => 8},     # single, monochrome channel
  :rgb8 => {:byte_size => 3, :bit_size => 24},  # red, green, blue, 8bits per channel
  :rgba8 => {:byte_size => 4, :bit_size => 32}, # red, green, blue, alpha 8bits per channel
  }
end
end
