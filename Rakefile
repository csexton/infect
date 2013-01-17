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
