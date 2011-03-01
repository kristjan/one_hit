class QuipsController < ApplicationController
  before_filter :load_site

  respond_to :html, :json, :xml

  def index
    @quips = Quip.all
    respond_with @quips
  end

  def show
    @quip = Quip.find(params[:id])
    respond_with @quip
  end

  def new
    @quip = Quip.new
    respond_with @quip
  end

  def edit
    @quip = Quip.find(params[:id])
  end

  def create
    @quip = Quip.new(params[:quip])
    if @quip.save
      respond_with @quip, :status => :created,
        :location => site_quip_url(@site, @quip),
        :notice => 'Quip was successfully created.'
    else
      respond_with @quip.errors, :status => :unprocessable_entity do |format|
        format.html  {render :new}
      end
    end
  end

  def update
    @quip = Quip.find(params[:id])
    if @quip.update_attributes(params[:quip])
      respond_with @quip, :location => site_quip_url(@site, @quip),
                   :notice => 'Quip was successfully updated.'
    else
      respond_with @quip.errors, :status => :unprocessable_entity do |format|
        format.html {render :edit}
      end
    end
  end

  def destroy
    @quip = Quip.find(params[:id])
    @quip.destroy
    respond_with @quip, :location => site_quips_url(@site), :head => :ok
  end

private

  def load_site
    @site = Site.find_by_slug(params[:site_id])
    redirect_to sites_url, :notice => "That site doesn't exist" unless @site
  end

end
