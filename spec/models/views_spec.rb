require 'spec_helper'

describe Views do
  it "requires a site" do
    Views.new.should have(1).error_on(:site)
  end

  it "initializes its fields to 0" do
    views = Views.new
    Views::TIME_PERIODS.each do |period|
      views.send(period).should == 0
    end
  end

  it "knows all its counts for convenience" do
    new_views.counts.should == [0,0,0]
  end

  describe "incrementing" do
    it "counts in memory" do
      views = new_views
      views.view!
      views.counts.should == [1,1,1]
    end

    it "counts in the database" do
      views = create_views
      views.view!
      views.reload
      views.counts.should == [1,1,1]
    end
  end

  describe "rolling over" do
    it "resets the daily count" do
      views = new_views
      views.view!
      views.rollover!
      views.today.should == 0
    end

    it "resets the weekly count on Monday" do
      monday = Date.today.beginning_of_week
      Date.stub(:today).and_return(monday)
      views = new_views
      views.view!
      views.rollover!
      views.this_week.should == 0
    end

    it "can be run on each view object" do
      all_views = [mock(Views), mock(Views)]
      all_views.each {|views| views.should_receive(:rollover!)}
      Views.stub(:all).and_return(all_views)
      Views.rollover!
    end
  end
end
