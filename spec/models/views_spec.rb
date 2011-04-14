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

  it "increments counts in memory" do
    views = new_views
    Views::TIME_PERIODS.each do |period|
      expect {views.view!}.to change(views, period).by(1)
    end
  end

  it "increments counts in the database" do
    views = create_views
    views.view!
    views.reload
    Views::TIME_PERIODS.map{|period| views.send(period)}.should == [1,1,1]
  end
end
