require 'spec_helper'

describe Authorization do
  it "requires a user" do
    Authorization.new.should have(1).error_on(:user)
  end

  it "requires a provider" do
    Authorization.new.should have(1).error_on(:provider)
    Authorization.new(:provider => '').should have(1).error_on(:provider)
  end

  it "requires an external uid" do
    Authorization.new.should have(1).errors_on(:uid)
  end

  it "doesn't require a token" do
    Authorization.new.should_not have(:any).errors_on(:token)
  end

  it "only allows one account of a given type" do
    auth = create_authorization
    new_authorization(:user => auth.user, :provider => auth.provider).
      should have(1).error_on(:provider)
  end

  it "only allows an account to be attached once" do
    auth = create_authorization
    new_authorization(:provider => auth.provider, :uid => auth.uid).
      should have(1).error_on(:uid)
  end
end
