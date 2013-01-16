require 'open-uri'
require 'fileutils'

module Infect
  class Command
    def self.build(command, args)
      case command.to_sym
      when :bundle
        Bundle.new(args)
      else
        $stderr.puts "WARNING: #{command} is not a valid command, ignorning"
      end
    end

    protected

    def mkdir(path)
      expanded_path = File.expand_path(path)
      unless File.directory?(expanded_path)
        notice "Making dir #{path}"
        FileUtils.mkdir_p(expanded_path)
      end
    end
    def chdir(path)
      Dir.chdir(path)
    end

    def download(url, path)
      File.open(File.expand_path(path), "w") do |file|
        open(url) do |read_file|
          file.write(read_file.read)
        end
      end
    end

    def colorize(code, str)
      "\e[#{code}m#{str}\e[0m"
    end
    def notice(str)
      puts colorize(32, str)
    end
    def error(str)
      puts colorize(31, str)
    end

  end
end
