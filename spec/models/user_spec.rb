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

  # Using a new User record here short circuits. Use a saved object to verify
  # that the correct SQL is built.
  it "has many Authorizations" do
    create_user.authorizations.should be_an(Array)
  end

  it "has many Badges" do
    create_user.badges.should be_an(Array)
  end

  it "has many Sites" do
    create_user.sites.should be_an(Array)
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

  describe "logging in" do
    before :each do
      @user = create_user(:password => 'god')
    end

    describe "with the right password" do
      it "returns the user" do
        User.find_by_login(:email => @user.email, :password => 'god').
          should == @user
      end
    end

    describe "with the wrong password" do
      it "returns a new user" do
        User.find_by_login(:email => @user.email, :password => 'dog').
          should be_new_record
      end

      it "sets the email" do
        User.find_by_login(:email => @user.email, :password => 'dog').email.
          should == @user.email
      end
    end

    it "returns nil when the email isn't found" do
      User.find_by_login(:email => @user.email.reverse).should be_nil
    end

    it "returns nil when you don't have an email" do
      User.find_by_login(:password => 'dog').should be_nil
    end
  end

  describe "the user's first name" do
    it "is the first word in their name, if there is one" do
      new_user(:name => "Bow Wow Wow").first_name.should == "Bow"
    end

    it "is the only word in their name, if there is just one" do
      new_user(:name => "Prince").first_name.should == "Prince"
    end

    it "is their email username if there is no name" do
      new_user(:name => nil, :email => "bow@wow.wow").first_name.should == 'bow'
    end
  end

end
