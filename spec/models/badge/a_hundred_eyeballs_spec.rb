require 'spec_helper'

describe Badge::AHundredEyeballs do
  it_should_behave_like 'badges'
  it_should_behave_like 'eyeballs badges'

  it "knows its threshold" do
    Badge::AHundredEyeballs.threshold.should == 100
  end
end
