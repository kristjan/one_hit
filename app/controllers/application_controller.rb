class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html, :json, :xml

private

  def next_url
    session[:next_url] || root_url
  end
  helper_method :next_url

  def viewer
    # TODO
  end
end
