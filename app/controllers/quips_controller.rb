class QuipsController < ApplicationController
  before_filter :load_site

  respond_to :html, :json, :xml

  def index
    @quips = @site.quips
    @quip = Quip.new(:site => @site)
    respond_with @quip
  end

  def show
    @quip = Quip.find(params[:id])
    respond_with @quip
  end

  def new
    respond_with @site.quips.build do |format|
      format.html { redirect_to site_quips_path(@site) }
    end
  end

  def edit
    @quip = Quip.find(params[:id])
    respond_with @quip do |format|
      format.html { redirect_to site_quips_path(@site) }
    end
  end

  def create
    @quip = Quip.new(params[:quip].merge(:site => @site))
    if @quip.save
      respond_with @quip, :status => :created,
        :location => site_quips_path(@site),
        :notice => 'Quip was successfully created.'
    else
      respond_with @quip.errors, :status => :unprocessable_entity do |format|
        format.html  {
          @quips = @site.quips
          render :index
        }
      end
    end
  end

  def update
    @quip = Quip.find(params[:id])
    if @quip.update_attributes(params[:quip])
      respond_with @quip, :location => site_quips_path(@site),
                   :notice => 'Quip was successfully updated.'
    else
      respond_with @quip.errors, :status => :unprocessable_entity do |format|
        @quips = @site.quips
        format.html {render :index}
      end
    end
  end

  def destroy
    @quip = Quip.find(params[:id])
    @quip.destroy
    respond_with @quip, :location => site_quips_path(@site), :head => :ok
  end

private

  def load_site
    @site = Site.fetch(params[:site_id])
    redirect_to sites_path, :notice => "That site doesn't exist" unless @site
  end

end
