require 'spec_helper'

describe ApplicationController do
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
end
