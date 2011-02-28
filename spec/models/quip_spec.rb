require 'spec_helper'

describe Quip do
  it "requires text" do
    Quip.new.should have(1).error_on(:text)
    Quip.new(:text => '').should have(1).error_on(:text)
  end

  it "requires a Site" do
    Quip.new.should have(1).error_on(:site)
  end

  it "belongs to a Site" do
    new_quip.site.should be_a(Site)
  end
end
