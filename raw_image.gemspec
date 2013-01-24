# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'raw_image/version'

Gem::Specification.new do |gem|
  gem.name          = "raw_image"
  gem.version       = RawImage::VERSION
  gem.authors       = ["Shane Brinkman-Davis"]
  gem.email         = ["shanebdavis@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'gui_geometry', ">= 0.1.1"
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'guard-test'
  gem.add_development_dependency 'rb-fsevent'
  gem.add_development_dependency 'simplecov'
end
