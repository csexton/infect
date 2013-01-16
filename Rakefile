require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
task :default => :spec

desc "Compile infect into a single file"
task :compile do
  $LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
  require 'infect/standalone'
  Infect::Standalone.save("infect")
end
