#!/usr/bin/env ruby
#
# Infect
#
# Asset Pipeline for Pathogen and Vim
#
require 'open-uri'
require 'fileutils'

class String
  def colorize(code); "\e[#{code}m#{self}\e[0m"; end
  def red; colorize(31); end
  def green; colorize(32); end
  def yellow; colorize(33); end
end

unless Dir.respond_to?(:home)
  class Dir
    class << self
      define_method :home do
        ENV['HOME']
      end
    end
  end
end


module Infect
  def self.run
    commands = []

    File.open( "#{ENV['HOME']}/.vimrc" ).each do |line|
      if line =~ /^"=/
        command, *args = line.split
        commands << Command.build(command.gsub('"=', ''), args)
      end
    end

    commands.compact.each do |command|
      command.call
    end
  end
end

if __FILE__ == $0
  Infect.run
end
