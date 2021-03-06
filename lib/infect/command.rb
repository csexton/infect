require 'open-uri'
require 'fileutils'

module Infect
  class Command
    include Infect::Colorize

    def self.build(command, arg ,opts)
      case command.to_sym
      when :plugin
        Plugin.new(arg, opts)
      when :bundle, :package
        Package.new(arg, opts)
      else
        $stderr.puts "WARNING: #{command} is not a valid command, ignorning"
      end
    end

    protected

    def mkdir(path)
      expanded_path = File.expand_path(path)
      unless File.directory?(expanded_path)
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
  end
end
