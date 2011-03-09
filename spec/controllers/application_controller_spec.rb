require 'spec_helper'

describe ApplicationController do
  describe "when there's :next_url in your session" do
    it "knows what it is" do
      session[:next_url] = '/nonsense'
      controller.send(:next_url).should == '/nonsense'
    end
  end

  describe "when there's no :next_url in your session" do
    it "defaults to root" do
      session[:next_url] = nil
      controller.send(:next_url).should == root_url
    end
  end
end
