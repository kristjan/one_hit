class SitesController < ApplicationController
  before_filter :load_site, :only => [:show, :edit, :update, :destroy]
  before_filter :require_creator, :only => [:edit, :update, :destroy]

  def index
    @site = Site.new
    @sites = Site.random(5).select{|s| s.quips.any?}
    respond_with @sites
  end

  def random
    @site = Site.random
    if @site
      respond_with @site, :location => site_path(@site) do |format|
        format.html {redirect_to @site}
      end
    else
      respond_with nil, :status => :not_found do |format|
        format.html {redirect_to sites_path}
      end
    end
  end

  def show
    if @site
      @site.view!
      @quip = @site.random_quip
      respond_with(@site)
    else
      respond_with_404
    end
  end

  def new
    @site = Site.new
    respond_with @site
  end

  def edit; end

  def create
    @site = Site.new(params[:site])
    @site.creator = viewer
    if @site.save
      pending_sites << @site.url
      respond_with @site, :status => :created do |format|
        format.html {redirect_to site_path(@site)}
      end
    else
      respond_with @site.errors, :status => :unprocessable_entity do |format|
        format.html {render :new}
      end
    end
  end

  def update
    if @site.update_attributes(params[:site])
      respond_with @site, :head => :ok,
        :notice => 'Site was successfully updated.'
    else
      respond_with @site.errors, :status => :unprocessable_entity do |format|
        format.html  {render :edit}
      end
    end
  end

  def destroy
    @site.destroy
    respond_with @site, :head => :ok, :location => sites_path
  end

end
