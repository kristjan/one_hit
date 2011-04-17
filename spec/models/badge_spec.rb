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
end
