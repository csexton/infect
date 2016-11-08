require 'open3'

module Infect
  class Command
    class Plugin < Command
      attr_reader :build, :location, :name, :options, :url

      def initialize(arg, opts)
        load = opts.fetch(:load) { "start" }
        package = opts.fetch(:package) { "default" }

        @name = File.basename(arg)
        @url = "git@github.com:#{arg}.git"
        @location = File.expand_path("#{PACK_DIR}/#{package}/#{load}/#{name}")
        @build = opts[:build]
      end

      def install
        notice "Installing #{name} to #{@location}..."
        parent_dir = File.expand_path("..", location)
        mkdir parent_dir
        chdir parent_dir
        git "clone --depth 1 '#{url}'"
      end

      def update
        notice "Updating #{name}..."
        chdir location
        git "fetch"
        git "checkout master"
      end

      def call
        if File.exists? location
          update
        else
          install
        end

        if build
          notice "  Found build command, running: '#{build}'"
          chdir location
          quiet_system "#{build.gsub(/^\"|\"?$/, '')}"
        end

        location
      end

      private

      def git(args)
        quiet_system "git #{args}"
      end

      def quiet_system(cmd)
        output = %x{#{cmd} 2>&1}
        unless $?.success?
          error "Command failed: #{cmd}\n"
          error output.gsub(/^/, "  ")
        end

      end
    end
  end
end
