class UsersController < ApplicationController
  def create
    @user = User.new(params[:user])
    if @user.save
      respond_with @user, :status => :created, :location => next_url
    else
      render :new
    end
  end

  def new
    @user = User.new
    @pending_sites = pending_sites.map{|url| Site.fetch(url)}
  end
end
