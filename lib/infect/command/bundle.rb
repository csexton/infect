module Infect
  class Command
    class Bundle < Command
      attr_reader :bundle, :name, :location
      def initialize(args)
        @bundle = args[0]
        @name = File.basename(bundle)
        @location = File.expand_path("~/.vim/bundle/#{name}")
      end

      def url
        "git@github.com:#{bundle}.git"
      end

      def install
        notice "Installing #{name}... "
        mkdir "~/.vim/bundle"
        chdir "#{VIMHOME}/bundle"
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
