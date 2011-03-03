class SitesController < ApplicationController

  respond_to :html, :json, :xml

  def index
    @sites = Site.all
    respond_with @sites
  end

  def show
    @site = Site.find_by_slug(params[:id])
    respond_with @site
  end

  def new
    @site = Site.new
    respond_with @site
  end

  def edit
    @site = Site.find_by_slug(params[:id])
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
    @site = Site.find_by_slug(params[:id])
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
    @site = Site.find_by_slug(params[:id])
    @site.destroy
    respond_with @site, :head => :ok, :location => sites_url
  end
end
