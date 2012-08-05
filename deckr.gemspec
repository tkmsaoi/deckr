# -*- encoding: utf-8 -*-
require File.expand_path("../lib/deckr/version", __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "deckr"
  gem.version       = Deckr::VERSION

  gem.authors       = ["Takamasa Aoi"]
  gem.email         = ["tkms.aoi@gmail.com"]
  gem.summary       = "utility for deck.js"
  gem.description   = <<EOS
Deckr is a utility for deck.js.

- Generate a Sinatra application for deck.js.
- Easy to write slides.
  - Provide shortcuts for managing Extension, Style and Transition.
  - Write slides with favorite template engine. (default is slim)
EOS
  gem.homepage      = "http://github.com/tkmsaoi/deckr"

  gem.files         = Dir["{bin,lib,spec}/**/*", "Gemfile", "LICENSE", "README.md", "Rakefile"]
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^spec/})
  gem.require_paths = ["lib"]

  gem.add_dependency "thor", "~> 0.15.3"
end
