class SitesController < ApplicationController

  respond_to :html, :json, :xml

  def index
    @sites = Site.all
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
    @site = Site.find_by_url(params[:id])
    respond_with @site
  end

  def new
    @site = Site.new
    respond_with @site
  end

  def edit
    @site = Site.find_by_url(params[:id])
  end

  def create
    @site = Site.new(params[:site])
    if @site.save
      respond_with @site, :status => :created,
        :location => site_quips_path(@site),
        :notice => 'Site was successfully created.'
    else
      respond_with @site.errors, :status => :unprocessable_entity do |format|
        format.html {render :new}
      end
    end
  end

  def update
    @site = Site.find_by_url(params[:id])
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
    @site = Site.find_by_url(params[:id])
    @site.destroy
    respond_with @site, :head => :ok, :location => sites_path
  end
end
