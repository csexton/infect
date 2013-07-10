module Infect
  class Command
    class Bundle < Command
      attr_reader :bundle, :name, :location
      def initialize(arg, opts)
        @bundle = arg
        @options = opts
        @name = File.basename(bundle)
        @location = File.expand_path("#{BUNDLE_DIR}/#{name}")
      end

      def url
        "git@github.com:#{bundle}.git"
      end

      def install
        notice "Installing #{name}... "
        mkdir BUNDLE_DIR
        chdir BUNDLE_DIR
        git "clone '#{url}'"
      end

      def update
        notice "Updating #{name}... "
        chdir @location
        git "pull"
      end

      def call
        if File.exists? @location
          update
        else
          install
        end
      end

      private

      def git(args)
        `git #{args}`
      end
    end
  end
end
