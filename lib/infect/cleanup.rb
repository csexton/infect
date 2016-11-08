module Infect
  class Cleanup
    include Infect::Colorize
    attr_reader :names, :force

    def initialize(list, args)
      @names = list.map{|p| File.basename(p)}
      @force = args[:force] || false
    end

    def call
      Dir["#{PACK_DIR}*/*/*"].each do |path|
        unless names.include? File.basename(path)
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

  end
end
