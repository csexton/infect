require "./lib/infect"
require 'tempfile'
require 'pry'
require 'tmpdir'

describe Infect::Runner do
  before do
    stub_const "Infect::VIMRC", file
    stub_const "Infect::BUNDLE_DIR", dir
  end

  let(:file) { Tempfile.new("rspec") }
  let(:dir) { Dir.mktmpdir }

  it "reads bundle command" do
    file.puts '"=bundle NoParams'
    file.close

    Infect::Command.stub(:builder)
    Infect::Command.should_receive(:build).with("bundle", "NoParams", {})
    Infect::Runner.call
  end

  it "reads bundle command" do
    file.puts '"=bundle ExtraParams param1:val1 param2: val2'
    file.close

    Infect::Command.stub(:builder)
    Infect::Command.should_receive(:build).with("bundle", "ExtraParams", {param1:"val1", param2:"val2"})
    Infect::Runner.call
  end


end
