require 'spec_helper'

describe UsersHelper do
  it "generates auth paths" do
    auth_path(:foo).should == '/auth/foo'
  end
end
