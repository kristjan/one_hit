class SitesController < ApplicationController

  def index
    @sites = Site.all

    respond_to do |format|
      format.html
      text_formats format, @sites
    end
  end

  def show
    @site = Site.find_by_slug(params[:id])

    respond_to do |format|
      format.html
      text_formats format, @site
    end
  end

  def new
    @site = Site.new

    respond_to do |format|
      format.html
      text_formats format, @site
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
        text_formats format, @site, :status => :created, :location => @site
      else
        format.html {render :action => "new"}
        text_formats format, @site.errors, :status => :unprocessable_entity
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
        text_formats(format) {head :ok}
      else
        format.html  {render :action => "edit"}
        text_formats format, @site.errors, :status => :unprocessable_entity
      end
    end
  end

  def destroy
    @site = Site.find_by_slug(params[:id])
    @site.destroy

    respond_to do |format|
      format.html  {redirect_to(sites_url)}
      text_formats(format) {head :ok}
    end
  end
end
