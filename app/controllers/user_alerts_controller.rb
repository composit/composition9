class UserAlertsController < ApplicationController
  before_filter :login_required

  def index
    if current_user.is_admin
      @user_alerts = UserAlert.all

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @user_alerts }
      end
    else
      redirect_to new_session_path
    end
  end

  def show
    if current_user.is_admin
      @user_alert = UserAlert.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @user_alert }
      end
    else
      redirect_to new_session_path
    end
  end

  def new
    if current_user.is_admin
      @user_alert = UserAlert.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @user_alert }
      end
    else
      redirect_to new_session_path
    end
  end

  def edit
    if current_user.is_admin
      @user_alert = UserAlert.find(params[:id])
    else
      redirect_to new_session_path
    end
  end

  def create
    if current_user.is_admin
      @user_alert = UserAlert.new(params[:user_alert])

      respond_to do |format|
        if @user_alert.save
          flash[:notice] = 'UserAlert was successfully created.'
          format.html { redirect_to(@user_alert) }
          format.xml  { render :xml => @user_alert, :status => :created, :location => @user_alert }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @user_alert.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to new_session_path
    end
  end

  def update
    @user_alert = UserAlert.find(params[:id])
    if current_user.is_admin || current_user == @user_alert.user
      respond_to do |format|
        if @user_alert.update_attributes(params[:user_alert])
          flash[:notice] = 'UserAlert was successfully updated.'
          format.html { redirect_to(@user_alert) }
          format.xml  { head :ok }
          format.js   { render :partial => '/users/user', :object => current_user }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @user_alert.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to new_session_path
    end
  end

  def destroy
    if current_user.is_admin
      @user_alert = UserAlert.find(params[:id])
      @user_alert.destroy

      respond_to do |format|
        format.html { redirect_to(user_alerts_url) }
        format.xml  { head :ok }
      end
    else
      redirect_to new_session_path
    end
  end
end
