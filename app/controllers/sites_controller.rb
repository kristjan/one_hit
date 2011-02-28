class SitesController < ApplicationController

  def index
    @sites = Site.all

    respond_to do |format|
      format.html
      api_formats format, @sites
    end
  end

  def show
    @site = Site.find_by_slug(params[:id])

    respond_to do |format|
      format.html
      api_formats format, @site
    end
  end

  def new
    @site = Site.new

    respond_to do |format|
      format.html
      api_formats format, @site
    end
  end

  def edit
    @site = Site.find_by_slug(params[:id])
  end

  def create
    @site = Site.new(params[:site])

    respond_to do |format|
      if @site.save
        format.html {
          redirect_to(@site, :notice => 'Site was successfully created.')
        }
        api_formats format, @site, :status => :created, :location => @site
      else
        format.html {render :action => "new"}
        api_formats format, @site.errors, :status => :unprocessable_entity
      end
    end
  end

  def update
    @site = Site.find_by_slug(params[:id])

    respond_to do |format|
      if @site.update_attributes(params[:site])
        format.html  {
          redirect_to(@site, :notice => 'Site was successfully updated.')
        }
        api_formats(format) {head :ok}
      else
        format.html  {render :action => "edit"}
        api_formats format, @site.errors, :status => :unprocessable_entity
      end
    end
  end

  def destroy
    @site = Site.find_by_slug(params[:id])
    @site.destroy

    respond_to do |format|
      format.html  {redirect_to(sites_url)}
      api_formats(format) {head :ok}
    end
  end
end
