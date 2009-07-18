class UsersController < ApplicationController

  layout "admin"

  # render new.rhtml
  def new
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    xml_user = { :percent => @user.total_percent_this_week }

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => xml_user }
    end
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    @user.save
    if @user.errors.empty?
      self.current_user = @user
      current_user.alerts.create(
        :action_statement => "created a user account"
      )
      flash[:notice] = "Thanks for signing up! Check your email inbox for instructions on activating your account."
      redirect_to :controller => "sessions", :action => "new"
    else
      render :action => 'new'
    end
  end

  def activate
    self.current_user = params[:activation_code].blank? ? false : User.find_by_activation_code(params[:activation_code])
    if logged_in? && !current_user.active?
      current_user.activate
      flash[:notice] = "Signup complete! Go ahead and log in."
    end
    redirect_to :controller => "sessions", :action => "new"
  end

end
