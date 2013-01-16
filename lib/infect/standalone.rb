module Infect
  # Inspired by https://github.com/defunkt/hub/blob/master/lib/hub/standalone.rb
  module Standalone
    extend self

    ROOT = File.expand_path('../../..', __FILE__)

    PREAMBLE = <<-preamble
#
# This file is generated code. DO NOT send patches for it.
#
# Original source files with comments are at:
# https://github.com/csexton/infect
#

preamble

    def save(filename, path = '.')
      target = File.join(File.expand_path(path), filename)
      File.open(target, 'w') do |f|
        build f
        f.chmod 0755
      end
    end

    def build io
      io.puts "#!#{ruby_executable}"
      io << PREAMBLE

      each_source_file do |filename|
        File.open(filename, 'r') do |source|
          source.each_line {|line| io << line if line !~ /^\s*#/ }
        end
        io.puts ''
      end

      io.puts "Infect::Runner.call(*ARGV)"
    end

    def each_source_file
      File.open(File.join(ROOT, 'lib/infect.rb'), 'r') do |main|
        main.each_line do |req|
          if req =~ /^require\s+["'](.+)["']/
            yield File.join(ROOT, 'lib', "#{$1}.rb")
          end
        end
      end
    end

    def ruby_executable
      if File.executable? '/usr/bin/ruby' then '/usr/bin/ruby'
      else
        require 'rbconfig'
        File.join RbConfig::CONFIG['bindir'], RbConfig::CONFIG['ruby_install_name']
      end
    end
  end
end
