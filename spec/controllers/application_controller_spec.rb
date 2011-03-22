require 'spec_helper'

describe ApplicationController do
  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

  it "knows what your :next_url is" do
    session[:next_url] = '/nonsense'
    controller.send(:next_url).should == '/nonsense'
  end

  it "has a default :next_url" do
    session[:next_url] = nil
    controller.send(:next_url).should == root_url
  end

  it "knows what sites are waiting to be claimed" do
    controller.send(:pending_sites) << '/waiting'
    controller.send(:pending_sites).should == ['/waiting']
  end

  it "knows if you're logged in" do
    user = new_user
    session[:viewer_id] = 42
    User.should_receive(:find_by_id).with(42).and_return(user)
    controller.send(:viewer).should == user
  end

  it "knows when you're not logged in" do
    session[:viewer_id] = nil
    controller.send(:viewer).should be_nil
  end

  describe "checking the viewer" do
    before :all do
      @user = create_user
    end

    before :each do
      controller.send :viewer!, @user
    end

    it "recognizes one user" do
      controller.send(:viewer?, @user).should be_true
    end

    it "recognizes an array of users" do
      controller.send(:viewer?, [@user]).should be_true
    end

    it "recognizes mixed users and arrays" do
      controller.send(:viewer?, new_user, [new_user, @user]).should be_true
    end

    it "recognizes when you're not someone we care about" do
      controller.send(:viewer?, new_user).should be_false
    end
  end

  describe "logging in" do
    before :each do
      session[:viewer_id] = nil
      controller.send(:viewer!, mock_user)
    end

    it "stores the viewer_id in the session" do
      session[:viewer_id].should == mock_user.id
    end

    it "sets the current viewer" do
      controller.send(:viewer).should == mock_user
    end
  end

  describe "logging out" do
    before :each do
      session[:viewer_id] = mock_user.id
      controller.send(:viewer!, nil)
    end

    it "wipes the session" do
      session[:viewer_id].should be_nil
    end

    it "clears the viewer" do
      controller.send(:viewer).should be_nil
    end
  end
end
