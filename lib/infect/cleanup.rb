module Infect
  class Cleanup
    include Infect::Colorize
    attr_reader :commands, :force

    def initialize(commands, args = {})
      @commands = commands
      @force = args[:force] || false
    end

    def call
      uninstall_unless_included names
    end

    private

    def uninstall_unless_included(list)
      Dir["#{BUNDLE_DIR}/*"].each do |path|
        unless list.include? File.basename(path)
          if confirm(path)
            notice "Deleting #{path}"
            require 'fileutils'
            FileUtils.rm_rf path
          else
            notice "Leaving #{path}"
          end
        end
      end
    end

    def confirm(name)
      unless force
        print "Remove #{name}? [Yn]: "
        response = STDIN.gets.chomp
        case response.downcase
        when ''
          true
        when 'y'
          true
        else
          false
        end
      end
    end

    def names
      list = []
      commands.each do |command|
        if command.respond_to? :name
          list << command.name
        end
      end
      list
    end

  end
end
