class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html, :json, :xml

private

  def next_url
    session[:next_url] || root_url
  end
  helper_method :next_url

  def load_site
    @site = Site.fetch(params[:id])
  end

  def pending_sites
    session[:pending_sites] ||= []
  end

  def require_creator
    return if @site.creator.nil?
    unless viewer?(@site.creator)
      respond_with :unauthorized, :status => 401,
                   :location => site_url(@site) do |format|
        format.html { redirect_to @site }
      end
    end
  end

  def viewer
    @viewer ||= (User.find_by_id(session[:viewer_id]) if session[:viewer_id])
  end
  helper_method :viewer

  def viewer?(*users)
    users.flatten.include?(viewer)
  end

  def viewer!(user)
    if user
      session[:viewer_id] = user.id
      @viewer = user
    else
      session.delete(:viewer_id)
      @viewer = nil
    end
  end

end
