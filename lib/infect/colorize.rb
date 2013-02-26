require 'open-uri'
require 'fileutils'

module Infect
  module Colorize
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

