require "gui_geometry"

%w{
  colors
  color
  color_formats
  image
  version
}.each do |file|
  require File.join(File.dirname(__FILE__),"raw_image",file)
end

module RawImage
  include GuiGeo
  def color(*args) Color.new *args; end
  def image(*args) Image.new *args; end
end
