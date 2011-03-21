class HealthController < ApplicationController
  def oops
    raise "I don't know that song."
  end

  def oops_js; end
end
