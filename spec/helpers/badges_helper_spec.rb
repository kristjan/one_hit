require 'spec_helper'

describe BadgesHelper do
  describe "generating badge tags" do
    before :each do
      @badge = new_badge
      @tag = badge_tag(@badge)
    end

    it "creates an image" do
      @tag.should =~ /<img/
    end

    it "sets the width" do
      @tag.should =~ /width="#{BadgesHelper::BADGE_SIZE}"/
    end

    it "sets the height" do
      @tag.should =~ /height="#{BadgesHelper::BADGE_SIZE}"/
    end

    it "sets the source" do
      @tag.should =~ %r(src="/images/#{@badge.image_path}")
    end

    it "sets the alt" do
      @tag.should =~ %r(alt="#{@badge.to_s}")
    end

    it "sets the title" do
      @tag.should =~ %r(title="#{@badge.to_s}")
    end
  end
end
