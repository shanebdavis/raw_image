require 'spec_helper'

module RawImage
describe "Color" do
  include ::RawImage
  include Colors

  it "new" do
    Color.new.to_s.should == "#000000ff"
    Color.new(0.5).to_s.should == "#7f7f7fff"
    Color.new(1).to_s.should == "#ffffffff"
    Color.new(1,0.5,0.25,0.1).to_s.should == "#ff7f3f19"
  end

  it "defined colors" do
    transparent.to_s.should == "#00000000"
    black.to_s.should == "#000000ff"
    gray.to_s.should == "#7f7f7fff"
    white.to_s.should == "#ffffffff"
  end

  it "accessors" do
    c = Color.new 0.1, 0.2, 0.3, 0.4
    c.r.should == 0.1
    c.g.should == 0.2
    c.b.should == 0.3
    c.a.should == 0.4
  end

  it "to_bytes - various values" do
    transparent.to_bytes(:rgba8).should == "\0\0\0\0"
    black.to_bytes(:rgba8).should == "\0\0\0\xff"
    white.to_bytes(:rgba8).should == "\xff\xff\xff\xff"
    Color.new(0.25,1,0.5,1).to_bytes(:rgba8).should == "?\xff\x7f\xff"
  end

  it "to_bytes - various formats" do
    gray.to_bytes(:g8).should == "\x7F"
    gray.to_bytes(:rgb8).should == "\x7F\x7F\x7F"
    gray.to_bytes(:rgba8).should == "\x7F\x7F\x7F\xFF"
  end

  it "set gray" do
    c = Color.new 0.1, 0.2, 0.3, 0.4
    c.gray = 0.25
    c.to_s.should == "#33333366"
  end

  it "inspect" do
    white.inspect.should == "color(1.0, 1.0, 1.0, 1.0)"
  end

  it "easy constructor" do
    color(0.1).to_s.should == "#191919ff"
  end
end
end
