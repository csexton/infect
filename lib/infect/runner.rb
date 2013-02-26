module Infect
  # Globals be global
  VIMHOME = ENV['VIM'] || "#{ENV['HOME']}/.vim"
  VIMRC = ENV['MYVIMRC'] || "#{ENV['HOME']}/.vimrc"
  BUNDLE_DIR = "#{VIMHOME}/bundle"

  class Runner
    def self.call(*args)
      force = args.include? "-f"

      commands = [Command::Prereqs.new()]

      File.open( VIMRC ).each do |line|
        if line =~ /^"=/
          command, *args = line.split
          commands << Command.build(command.gsub('"=', ''), args)
        end
      end

      #commands.compact.each do |command|
      #  command.call
      #end

      Cleanup.new(commands, :force => force).call

    end
  end
end
