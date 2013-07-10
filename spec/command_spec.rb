require "./lib/infect"

describe Infect::Command do
  it "build a nil class when given a bad command" do
    Infect::Command.build("blargl", "bangle", {}).should be_nil
  end

  it "build a bundle command" do
    Infect::Command.build("bundle", "tpope/vim-pathogen", {}).name.should == "vim-pathogen"
  end
end
