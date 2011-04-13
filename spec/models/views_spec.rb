require 'spec_helper'

describe Views do
  it "requires a site" do
    Views.new.should have(1).error_on(:site)
  end

  it "initializes its fields to 0" do
    views = Views.new
    views.today.should == 0
    views.this_week.should == 0
    views.all_time.should == 0
  end
end
