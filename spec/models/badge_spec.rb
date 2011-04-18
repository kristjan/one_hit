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
    Badge.grant(user, :create)
  end

  describe "routing" do
    describe "User creation" do
      it "notifies StraightOuttaTheLab" do
        user = new_user
        Badge::StraightOuttaTheLab.should_receive(:grant).with(user, :create)
        Badge.grant(user, :create)
      end
    end
  end

  Badge.descendants.each do |badge|
    describe badge do
      it "has a description (#{badge})" do
        badge.description.should_not be_empty
      end

      it "can access the description from an instance" do
        badge.new.description.should == badge.description
      end
    end
  end

  describe "StraightOuttaTheLab" do
    before :each do
      @user = new_user
    end

    describe "before July 1" do
      before :each do
        Date.stub(:today).and_return(Date.new(2011,6,30))
      end

      it "is granted to a new user" do
        Badge::StraightOuttaTheLab.should_receive(:create).
          with(hash_including(:user => @user))
        Badge::StraightOuttaTheLab.grant(@user, :create)
      end

      it "is only granted to Users" do
        Badge::StraightOuttaTheLab.should_not_receive(:create)
        Badge::StraightOuttaTheLab.grant(new_site, :create)
      end
    end

    describe "on or after July 1" do
      before :each do
        Date.stub(:today).and_return(Date.new(2011,7,1))
      end

      it "is not granted" do
        Badge::StraightOuttaTheLab.should_not_receive(:create)
        Badge::StraightOuttaTheLab.grant(@user, :create)
      end
    end
  end
end
