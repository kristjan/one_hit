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

  it "doesn't require a secret" do
    Authorization.new.should_not have(:any).errors_on(:secret)
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

  describe "find_by_hash" do
    it "returns a matching auth" do
      auth = create_authorization
      Authorization.find_by_hash('provider' => auth.provider,
                                 'uid' => auth.uid).should == auth
    end

    it "returns nil when there is no matching auth" do
      Authorization.find_by_hash({'provider' => 'giver', 'uid' => 'jonas'}).
        should be_nil
    end

    it "returns nil when there is no provider" do
      Authorization.find_by_hash({'uid' => 'jonas'}).should be_nil
    end

    it "returns nil when there is no user" do
      Authorization.find_by_hash({'provider' => 'giver'}).should be_nil
    end
  end

  describe "building a new authorization" do
    before :each do
      @auth_info = {
        'provider' => 'giver',
        'uid' => 'jonas',
        'credentials' => {
          'token' => Faker::Lorem.words.join,
          'secret' => Faker::Lorem.words.join
        },
        'user_info' => {
          'name' => 'Jonas of Giville'
        }
      }
    end

    describe "when there is a user" do
      before :each do
        @user = create_user
      end

      it "attaches the authorization" do
        Authorization.build(@user, @auth_info)
        @user.authorizations.should(include do |auth|
          auth.provider == @auth_info['provider'] &&
          auth.uid      == @auth_info['uid']
        end)
      end
    end

    describe "when there is not a user" do
      it "creates the user and attaches the authorization" do
        @user = create_user
        User.stub(:create!).and_return(@user)
        Authorization.build(nil, @auth_info)
        @user.authorizations.should(include do |auth|
          auth.provider == @auth_info['provider'] &&
          auth.uid      == @auth_info['uid']
        end)
      end
    end
  end
end
