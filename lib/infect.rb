lib = File.expand_path('..', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'infect/version'
require 'infect/colorize'
require 'infect/command'
require 'infect/command/plugin'
require 'infect/command/package'
require 'infect/command/prereqs'
require 'infect/cleanup'
require 'infect/runner'
