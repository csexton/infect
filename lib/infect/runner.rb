module Infect
  # Globals be global
  VIMHOME = ENV['VIM'] || "#{ENV['HOME']}/.vim"
  VIMRC = ENV['MYVIMRC'] || "#{ENV['HOME']}/.vimrc"
  PACK_DIR = "#{VIMHOME}/pack/"

  class Runner
    def self.call(*args)
      self.new.call(args)
    end

    def call(*args)
      force = args.include? "-f"

      Command::Prereqs.new().call

      commands = get_packages_from_vimrc
      commands.compact.each(&:call)

      locations = commands.map(&:location)
      Cleanup.new(locations, :force => force).call
    end

    private

    def get_packages_from_vimrc
      File.readlines(VIMRC).map do |line|
        if line =~ /^"=/
          command, arg, opts = parse_command(line.gsub('"=', ''))
          Command.build(command, arg, opts)
        end
      end.compact
    end

    def parse_command(line)
      # TODO: pass in named params after for things like build commands and
      # branches
      #
      # "bundle BundleName build: "make -f file", branch: awesome
      #
      # So this will split the command into 3 parts
      # Now we can take args and split by ',' the split those by ':' and
      # map that to a hash that we can pass into the command builder

      # This splits and perserves "quoted words"
      #command, *args = line.split /\s(?=(?:[^"]|"[^"]*")*$)/

      #command, *args = line.split

      command, arg, opts_string = line.split ' ', 3
      [command, arg, parse_opts(opts_string)]
    end

    def parse_opts(string)
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
