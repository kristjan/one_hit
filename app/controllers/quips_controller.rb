class QuipsController < ApplicationController
  before_filter :load_site

  # GET /quips
  # GET /quips.xml
  def index
    @quips = Quip.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  {render :xml => @quips}
    end
  end

  # GET /quips/1
  # GET /quips/1.xml
  def show
    @quip = Quip.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  {render :xml => @quip}
    end
  end

  # GET /quips/new
  # GET /quips/new.xml
  def new
    @quip = Quip.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  {render :xml => @quip}
    end
  end

  # GET /quips/1/edit
  def edit
    @quip = Quip.find(params[:id])
  end

  # POST /quips
  # POST /quips.xml
  def create
    @quip = Quip.new(params[:quip])

    respond_to do |format|
      if @quip.save
        format.html {
          redirect_to site_quip_url(@site, @quip),
            :notice => 'Quip was successfully created.'
        }
        format.xml  {
          render :xml => @quip, :status => :created, :location => @quip
        }
      else
        format.html {render :action => "new"}
        format.xml  {
          render :xml => @quip.errors, :status => :unprocessable_entity
        }
      end
    end
  end

  # PUT /quips/1
  # PUT /quips/1.xml
  def update
    @quip = Quip.find(params[:id])

    respond_to do |format|
      if @quip.update_attributes(params[:quip])
        format.html {
          redirect_to site_quip_url(@site, @quip),
            :notice => 'Quip was successfully updated.'
        }
        format.xml  {head :ok}
      else
        format.html {render :action => "edit"}
        format.xml  {
          render :xml => @quip.errors, :status => :unprocessable_entity
        }
      end
    end
  end

  # DELETE /quips/1
  # DELETE /quips/1.xml
  def destroy
    @quip = Quip.find(params[:id])
    @quip.destroy

    respond_to do |format|
      format.html {redirect_to(site_quips_url(@site.slug))}
      format.xml  {head :ok}
    end
  end

private

  def load_site
    @site = Site.find_by_slug(params[:site_id])
    redirect_to sites_url, :notice => "That site doesn't exist" unless @site
  end

end
