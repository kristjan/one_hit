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

  it "doesn't duplicate emails" do
    user = create_user
    User.new(:email => user.email).should have(1).error_on(:email)
  end

  it "can claim sites" do
    sites = [new_site, new_site]
    user = create_user
    sites.each do |site|
      Site.stub(:fetch).with(site.url) { site }
      site.should_receive(:update_attributes).with(:creator_id => user.id)
    end
    user.claim_sites(sites.map(&:url))
  end

  describe "encrypting your password" do
    it "happens upon save" do
      User.new._save_callbacks.find do |callback|
        callback.kind == :before && callback.filter == :encrypt_password!
      end.should be
    end

    it "sets the crypted_password to something other than your password" do
      user = new_user(:password => 'god')
      user.encrypt_password!
      user.crypted_password.should_not be_blank
      user.crypted_password.should =~ /[a-f0-9]{40}/
    end

    it "does nothing if password is not present" do
      user = new_user(:crypted_password => 'dog')
      user.encrypt_password!
      user.crypted_password.should == 'dog'
    end
  end

end
