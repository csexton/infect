# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'infect/version'

Gem::Specification.new do |gem|
  gem.name          = "infect"
  gem.version       = Infect::VERSION
  gem.authors       = ["Christopher Sexton"]
  gem.email         = ["csexton@gmail.com"]
  gem.description   = %q{Bundle manager for pathogen.vim}
  gem.summary       = %q{Asset Pipeline for Pathogen, install vim bundles based on comments in your vimrc}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
