require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
task :default => :spec

file "./standalone/infect" => FileList.new("lib/infect.rb", "lib/infect/*.rb") do |task|
  $LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
  require 'infect/standalone'
  Infect::Standalone.save("./standalone/infect")
end

desc "Build standalone script"
task :standalone => "./standalone/infect"

namespace :build do
  task :standalone_parallel => [:clean] do
    Rake::Task[:standalone].invoke
    pmap = Gem::Specification.find_by_name('pmap')
    pmap_lib = Dir["#{File.join(pmap.lib_dirs_glob, 'pmap.rb')}"].first
    content = File.read(pmap_lib)

    preamble = <<PREAMBLE

#####
# This file is generated code. DO NOT send patches for it.
#
# Original source files with comments are at:
# https://github.com/csexton/infect
#####

PREAMBLE
    license = File.read("#{File.join(pmap.lib_dirs_glob, '..', 'LICENSE')}")
    infect = File.read('standalone/infect')
                 .gsub(%r{#!/usr/bin/.* ruby$}, '')
                 .gsub(%r{#!/usr/bin/ruby$}, '')
                 .gsub(%r{require 'pmap'}, '')
    output = [ "#!/usr/bin/env ruby",
                     preamble,
                     "=begin",
                     "Content related to pmap belongs to the #{pmap.name} gem",
                     "See source at https://github.com/bruceadams/pmap",
                     "License",
                     license,
                     "=end",
                     content,
                     "# End of PMap gem",
                     infect,
                   ].join("\n")

    File.write(File.expand_path('standalone/infect'), output)
  end
end

task :clean do
  FileUtils.rm_f 'standalone/infect'
end
