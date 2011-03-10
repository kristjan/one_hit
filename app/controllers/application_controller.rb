class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html, :json, :xml

private

  def next_url
    session[:next_url] || root_url
  end
  helper_method :next_url

  def pending_sites
    session[:pending_sites] ||= []
  end

  def viewer
    @viewer ||= (User.find_by_id(session[:viewer_id]) if session[:viewer_id])
  end
end
