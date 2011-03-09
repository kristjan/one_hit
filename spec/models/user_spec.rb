require 'spec_helper'

describe User do
  it "doesn't require a name" do
    User.new.should_not have(:any).errors_on(:name)
  end

  it "doesn't require a password" do
    User.new.should_not have(:any).errors_on(:crypted_password)
  end

  it "doesn't require an email" do
    User.new.should_not have(:any).errors_on(:email)
  end
end
