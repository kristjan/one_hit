class QuipsController < ApplicationController
  before_filter :load_site

  def index
    @quips = Quip.all

    respond_to do |format|
      format.html
      api_formats format, @quips
    end
  end

  def show
    @quip = Quip.find(params[:id])

    respond_to do |format|
      format.html
      api_formats format, @quip
    end
  end

  def new
    @quip = Quip.new

    respond_to do |format|
      format.html
      api_formats format, @quip
    end
  end

  def edit
    @quip = Quip.find(params[:id])
  end

  def create
    @quip = Quip.new(params[:quip])

    respond_to do |format|
      if @quip.save
        format.html {
          redirect_to site_quip_url(@site, @quip),
            :notice => 'Quip was successfully created.'
        }
        api_formats format, @quip,
          :status => :created, :location => site_quip_url(@site, @quip)
      else
        format.html  {render :action => "new"}
        api_formats format, @quip.errors, :status => :unprocessable_entity
      end
    end
  end

  def update
    @quip = Quip.find(params[:id])

    respond_to do |format|
      if @quip.update_attributes(params[:quip])
        format.html {
          redirect_to site_quip_url(@site, @quip),
            :notice => 'Quip was successfully updated.'
        }
        api_formats(format) {head :ok}
      else
        format.html {render :action => "edit"}
        api_formats format, @quip.errors, :status => :unprocessable_entity
      end
    end
  end

  def destroy
    @quip = Quip.find(params[:id])
    @quip.destroy

    respond_to do |format|
      format.html {redirect_to(site_quips_url(@site.slug))}
      api_formats(format) {head :ok}
    end
  end

private

  def load_site
    @site = Site.find_by_slug(params[:site_id])
    redirect_to sites_url, :notice => "That site doesn't exist" unless @site
  end

end
