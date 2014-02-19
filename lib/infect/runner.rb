require 'pmap'
module Infect
  # Globals be global
  VIMHOME = ENV['VIM'] || "#{ENV['HOME']}/.vim"
  VIMRC = ENV['MYVIMRC'] || "#{ENV['HOME']}/.vimrc"
  BUNDLE_DIR = "#{VIMHOME}/bundle"

  class Runner
    def self.call(*args)
      force = args.include? "-f"

      commands = [Command::Prereqs.new()]

      File.open( VIMRC ).each_line do |line|
        if line =~ /^"=/
          command, arg, opts = parse_command(line.gsub('"=', ''))
          commands << Command.build(command, arg, opts)
        end
      end

      commands.compact.peach(&:call)

      Cleanup.new(commands, :force => force).call

    end

    private

    def self.parse_command(line)
      # TODO: pass in named params after for things like build commands and
      # branches
      #
      # "bundle BundleName build: "make -f file", branch: awesome
      #
      # So this will split the command into 3 parts
      # Now we can take args and split by ',' the split those by ':' and
      # map that to a hash that we can pass into the command builder

      # This splits adn perserves "quoted words"
      #command, *args = line.split /\s(?=(?:[^"]|"[^"]*")*$)/

      #command, *args = line.split

      command, arg, opts_string = line.split ' ', 3
      [command, arg, parse_opts(opts_string)]
    end

    def self.parse_opts(string)
      hash = {}
      # Woah now.
      #
      # The first split and regex will perserver quoted strings" and split on
      # whitespace or colons.
      #
      # The reject removes any duplicate empty strings that the split might
      # create when it encounters a colon and space next to each other
      # (something like this: ": " will do that)
      parts = string.split(/[\s:](?=(?:[^"]|"[^"]*")*$)/).reject! { |c| c.empty? }
      if parts
        parts.each_slice(2) do |key, val|
          hash[key.to_sym] = val
        end
      end
      hash
    end
  end
end
