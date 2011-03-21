require 'spec_helper'

describe HealthController do

  describe "GET 'oops'" do
    it "should raise an error" do
      expect { get 'oops' }.to raise_error
    end
  end

  describe "GET 'oops_js'" do
    it "should render the JS error template" do
      get 'oops_js'
      response.should render_template(:oops_js)
    end
  end

end
