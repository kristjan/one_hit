class ApplicationController < ActionController::Base
  include ApiFormats

  protect_from_forgery
end
