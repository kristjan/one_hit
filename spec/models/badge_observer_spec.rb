require 'spec_helper'

describe BadgeObserver do
  describe "creations" do
    it "watches for new users" do
      Badge.should_receive(:grant).with(an_instance_of(User), :create)
      create_user
    end
  end
end
