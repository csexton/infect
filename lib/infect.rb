lib = File.expand_path('..', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'infect/version'
require 'infect/command'
require 'infect/command/bundle'
require 'infect/command/prereqs'
require 'infect/runner'
