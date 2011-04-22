require 'spec_helper'

describe Badge::StraightOuttaTheLab do
  before :each do
    @user = new_user
  end

  it "is notified upon User creation" do
    Badge::StraightOuttaTheLab.should_receive(:grant).with(an_instance_of(User))
    create_user
  end

  describe "before July 1" do
    before :each do
      Date.stub(:today).and_return(Date.new(2011,6,30))
    end

    it "is granted to a new user" do
      Badge::StraightOuttaTheLab.should_receive(:create).
        with(hash_including(:user => @user))
      Badge::StraightOuttaTheLab.grant(@user)
    end

    it "is only granted to Users" do
      Badge::StraightOuttaTheLab.should_not_receive(:create)
      Badge::StraightOuttaTheLab.grant(new_site)
    end
  end

  describe "on or after July 1" do
    before :each do
      Date.stub(:today).and_return(Date.new(2011,7,1))
    end

    it "is not granted" do
      Badge::StraightOuttaTheLab.should_not_receive(:create)
      Badge::StraightOuttaTheLab.grant(@user)
    end
  end
end
