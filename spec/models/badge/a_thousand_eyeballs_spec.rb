require 'spec_helper'

describe Badge::AThousandEyeballs do
  it_should_behave_like 'badges'
  it_should_behave_like 'eyeballs badges'

  it "knows its threshold" do
    Badge::AThousandEyeballs.threshold.should == 1000
  end
end
