require 'spec_helper'

shared_examples_for 'badges' do
  it "has an image file" do
    file_path = File.join(Rails.root, 'public', 'images',
                          described_class.new.image_path)
    assert File.exists?(file_path)
  end
end

shared_examples_for 'eyeballs badges' do
  it "is notified when a Views is updated" do
    views = new_views
    described_class.should_receive(:grant).with(views)
    views.view!
  end

  it "doesn't grant to something other than Views" do
    described_class.should_not_receive(:create)
    described_class.grant(new_user)
  end

  it "doesn't grant below its threshold" do
    views = new_views
    described_class.should_not_receive(:create)
    described_class.grant(views)
  end

  it "grants at its threshold" do
    views = new_views(:all_time => described_class::THRESHOLD)
    described_class.should_receive(:create)
    described_class.grant(views)
  end

  it "does not grant again above its threshold" do
    views = new_views(:all_time => described_class::THRESHOLD + 1)
    described_class.should_not_receive(:create)
    described_class.grant(views)
  end
end
