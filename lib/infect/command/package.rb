module Infect
  class Command
    class Package < Plugin
      def initialize(arg, opts)
        super
        @location = File.expand_path("#{PACK_DIR}/#{name}")
      end
    end
  end
end
