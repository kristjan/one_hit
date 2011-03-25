class UsersController < ApplicationController
  def authorize
    auth_info = request.env['rack.auth']
    auth = Authorization.find_or_build(auth_info, viewer)
    viewer!(auth.user)
    redirect_to next_url
  end

  def create
    login_user || create_user
    viewer!(@user)
  end

  def new
    @user = User.new
    @pending_sites = pending_sites.map{|url| Site.fetch(url)}
  end

private

  def create_user
    @user = User.new(params[:user])
    if @user.save
      @user.claim_sites(pending_sites)
      respond_with @user, :status => :created, :location => next_url
    else
      render :new
    end
  end

  def login_user
    @user = User.find_by_login(params[:user])
    return if @user.nil?
    if @user.new_record?
      render :new
    else
      @user.claim_sites(pending_sites)
      respond_with @user, :location => next_url
    end
  end

end
