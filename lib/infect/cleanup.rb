module Infect
  class Cleanup
    include Infect::Colorize
    attr_reader :names, :force

    def initialize(list, args)
      @names = list.map{|p| File.basename(p)}
      @force = args[:force] || false
    end

    def call
      install_paths.each do |path|
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

    private

    def install_paths
      # Get the list of directories that plugins might be installed to, since
      # we install legacy plugins in a special directory we want to look under
      # that as well as in the top level `pack` directory.

      default_dir = Command::Plugin::DEFAULT_DIR
      plugins = Dir["#{PACK_DIR}#{default_dir}/*/*"]
      packages = Dir["#{PACK_DIR}*"]
      packages.delete("#{PACK_DIR}#{default_dir}")

      plugins + packages
    end

  end
end
