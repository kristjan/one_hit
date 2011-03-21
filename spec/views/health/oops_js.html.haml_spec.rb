require 'spec_helper'

describe "health/oops_js.html.haml" do
  it "raises a JS exception" do
    render
    assert_select "script[type='text/javascript']", :text => /throw/
  end
end
