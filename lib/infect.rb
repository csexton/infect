require 'open-uri'
require 'fileutils'
lib = File.expand_path('..', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'infect/version'
require 'infect/command'
require 'infect/command/bundle'

module Infect
  # Globals be global
  VIMHOME = ENV['VIM'] || "#{ENV['HOME']}/.vim"
  VIMRC = ENV['MYVIMRC'] || "#{ENV['HOME']}/.vimrc"


  def self.run
    commands = []

    File.open( VIMRC ).each do |line|
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
