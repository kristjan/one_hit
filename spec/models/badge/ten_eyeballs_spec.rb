require 'spec_helper'

describe Badge::TenEyeballs do
  it_should_behave_like 'badges'
  it_should_behave_like 'eyeballs badges'

  it "knows its threshold" do
    Badge::TenEyeballs.threshold.should == 10
  end
end
