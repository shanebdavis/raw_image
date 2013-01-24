# RawImage

Store uncompressed bitmap images efficiently in Ruby. Provides some basic image manipulations. Is intended to be the basis for other gems that want to work with raw, uncompressed images.

## Installation

Add this line to your application's Gemfile:

    gem 'raw_image'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install raw_image

## Usage

```
require "raw_image"
include RawImage

# create 10 wide and 5 pixel high black rgba image
image(:size => point(10,5))

# create 10 wide and 5 pixel high white rgba image
image(:size => point(10,5), :color => white)

# create 10 wide and 5 pixel high white rgb image
image(:size => point(10,5), :color => white, :format => :rgb8)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
