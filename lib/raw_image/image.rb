# encoding: BINARY

module RawImage
class Image
  include GuiGeo
  include RawImage
  include Colors

  # raw image data as a binary string
  attr_reader :data

  # width & height of the image
  attr_reader :size

  # pixel format of iamge
  attr_reader :format

  # length of each line in bytes
  attr_reader :line_byte_size

  # :format => symbol
  # :size => point
  # :data => string
  # :line_byte_size => integer or nil
  # :color => Color (clear-to-color if data is nil)
  def initialize(options={})
    @format = options[:format] || :rgba8
    raise ArgumentError.new("unsupported format: #{format.inspect}") unless RawImage.color_formats[format]

    @size = options[:size]
    raise ArgumentError.new("size#{size} must be at least (1,1)") unless size > point

    @line_byte_size = options[:line_byte_size] || minimum_line_byte_size
    raise ArgumentError.new("line_byte_size must be at least #{minimum_line_byte_size} for the given format #{format.inspect} and size #{size}") unless line_byte_size >= minimum_line_byte_size

    @data = options[:data] || new_data(options[:color])
    raise ArgumentError.new("expecting data to be #{byte_size} bytes (was #{data.length})") unless data.length == byte_size
  end

  # total byte-size of the string (should always == data.length)
  def byte_size; size.y * line_byte_size; end

  # number of pixels in image
  def pixel_size; size.x * size.y; end

  # bytes per pixel
  def pixel_byte_size; RawImage.color_formats[format][:byte_size]; end

  # the rectangle defining the area of the image
  def area; rect size; end

  # get the byte-offset into data of a given pixel location
  def byte_offset(loc) loc.y * line_byte_size + loc.x * pixel_byte_size; end

  # return the byte of a single horizontal sub-line of data
  # (start is a GuiGeo::Point)
  def sub_horizontal_line(start, length)
    offset = byte_offset start
    data[offset .. (offset + (length*pixel_byte_size)-1)]
  end

  # return a new image with the pixels from the specified sub_area (GuiGeo::Rectangle)
  def subimage(sub_area)
    sub_area = area | sub_area

    byte_width_minus_one = sub_area.w * pixel_byte_size - 1
    stride = line_byte_size
    offset = byte_offset(sub_area.loc) - stride
    data = @data
    Image.new :size => sub_area.size, :format => format, :data => (sub_area.h.times.collect do
      offset += stride
      data[offset .. (offset + byte_width_minus_one)]
    end).join
  end

  # replace the pixels of the given sub_area (GuiGeo::Rectangle) with the specified Image::Color
  def replace_rect(sub_area, color)
    sub_area = area | sub_area
    return unless sub_area.present?

    replace_line = color.to_bytes(format) * sub_area.w

    data = @data
    each_line(sub_area) do |range|
      data[range] = replace_line
    end
  end

  # replace the pixels of the given sub_area (GuiGeo::Rectangle) with the pixels of the given image (Image)
  # optional: specify a sub-area of the source image to copy
  def replace_image(loc, image, source_sub_area = nil)
    raise ArgumentError.new unless format == image.format
    loc -= source_sub_area.loc if source_sub_area
    source_sub_area = (area - loc) | image.area | source_sub_area
    target_sub_area = source_sub_area + loc
    return unless target_sub_area.present?

    data = @data
    w = source_sub_area.w
    l = source_sub_area.loc
    each_line(target_sub_area) do |range|
      data[range] = image.sub_horizontal_line(l, w)
      l.y += 1
    end
  end

  private
  def minimum_line_byte_size; size.x * pixel_byte_size; end

  # assumes sub_area is a strict sub_area of self.area
  def each_line(sub_area)
    byte_width_minus_one = sub_area.w * pixel_byte_size - 1
    stride = line_byte_size
    offset = byte_offset(sub_area.loc) - stride

    sub_area.h.times do
      offset += stride
      range = offset .. (offset + byte_width_minus_one)
      yield range
    end
  end

  def new_data(color)
    color ||= transparent
    color_string = color.to_bytes(format)
    color_string * pixel_size
  end
end
end
