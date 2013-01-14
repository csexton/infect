# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'infect/version'

Gem::Specification.new do |gem|
  gem.name          = "infect"
  gem.version       = Infect::VERSION
  gem.authors       = ["Christopher Sexton"]
  gem.email         = ["csexton@gmail.com"]
  gem.description   = %q{Asset Pipeline for Pathogen.vim}
  gem.summary       = %q{Asset Pipeline for Vim and Pathogen, install vim bundles included in your vimrc}
  gem.homepage      = "https://github.com/csexton/infect"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_development_dependency('rspec')
end
