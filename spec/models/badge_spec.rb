require 'spec_helper'

describe Badge do
  it "belongs to a user" do
    new_badge.user.should be_a(User)
  end

  it "requires a user" do
    Badge.new.should have(1).error_on(:user)
  end

  it "requires a type" do
    Badge.new.should have(1).error_on(:type)
  end

  it "can only be given to a user once" do
    badge = create_badge
    new_badge(:user => badge.user, :type => badge.type).
      should have(1).error_on(:type)
  end

  it "prints nicely" do
    new_badge.to_s.should == "Test Pilot"
  end

   it "prints underscored" do
     new_badge.to_s(:underscore).should == "test_pilot"
   end

  it "knows where its image lives" do
    badge = new_badge
    badge.image_path.should == "badges/test_pilot.png"
  end

  it "knows if it's been granted" do
    user = create_user
    Badge::TestPilot.granted?(user).should be_false
    Badge::TestPilot.create(:user => user)
    Badge::TestPilot.granted?(user).should be_true
  end

  it "does not grant the same badge twice" do
    user = new_user
    Badge::TestPilot.stub(:granted?).with(user).and_return(true)
    Badge::TestPilot.should_not_receive(:grant)
    Badge.grant(user)
  end

  it "doesn't try to grant a badge to a nil target" do
    Badge::TestPilot.should_not_receive(:grant)
    Badge.grant(mock(Site, :badge_target => nil))
  end

  it "eager-loads its descendants" do
    Dir[File.join(Rails.root, 'app', 'models', 'badge', '*')].each do |badge|
      Object.should_receive(:require).with(badge)
    end
    Badge.require_descendants
  end
end
