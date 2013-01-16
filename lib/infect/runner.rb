module Infect
  # Globals be global
  VIMHOME = ENV['VIM'] || "#{ENV['HOME']}/.vim"
  VIMRC = ENV['MYVIMRC'] || "#{ENV['HOME']}/.vimrc"

  class Runner
    def self.call(*args)
      commands = [Command::Prereqs.new()]

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
end
