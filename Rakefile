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
    license = File.read("#{File.join(pmap.lib_dirs_glob, '..', 'LICENSE')}")
    File.open('standalone/infect', 'a') do |f|
      appending_content = [
        "\n\n",
        "=begin",
        "Content below belongs to the #{pmap.name} gem",
        "License",
        license,
        "=end",
        "require 'pmap'",
        content,
      ].join("\n")
      f << appending_content
    end
  end
end

task :clean do
  FileUtils.rm_f 'standalone/infect'
end
