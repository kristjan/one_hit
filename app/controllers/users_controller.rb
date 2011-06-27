class UsersController < ApplicationController
  before_filter :load_user, :only => [:edit, :show, :update]
  before_filter :require_correct_user, :only => [:edit, :update]

  def authorize
    auth_info = request.env['rack.auth']
    auth = Authorization.find_by_hash(auth_info)
    flan(:pageview, 'users/create') if viewer.nil? && auth.nil?
    auth ||= Authorization.build(viewer, auth_info)
    auth.user.claim_sites(pending_sites)
    viewer!(auth.user)
    redirect_to next_url
  end

  def create
    login_user || create_user
    viewer!(@user)
  end

  def edit
    @user ? respond_with(@user) : respond_with_404
  end

  def new
    @user = User.new
    session[:next_url] = params[:next_url] unless params[:next_url].blank?
  end

  def show
    @user ? respond_with(@user) : respond_with_404
  end

  def update
    if @user.update_attributes(params[:user])
      respond_with @user, :head => :ok,
        :notice => "It's almost like you're a new person!"
    else
      respond_with @user.errors, :status => :unprocessable_entity do |format|
        format.html  {render :edit}
      end
    end
  end

private

  def create_user
    @user = User.new(params[:user])
    if @user.save
      @user.claim_sites(pending_sites)
      flan(:pageview, 'users/create')
      respond_with @user, :status => :created, :location => next_url
    else
      render :new
    end
  end

  def load_user
    @user = User.find_by_id(params[:id])
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

  def require_correct_user
    unless viewer?(@user)
      respond_with :unauthorized, :status => 401,
                   :location => user_path(@user) do |format|
        format.html { redirect_to @user }
      end
    end
  end

end
