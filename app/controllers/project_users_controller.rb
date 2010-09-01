class ProjectUsersController < ApplicationController
  layout "admin"

  before_filter :login_required

  def index
    @project_users = ProjectUser.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @project_users }
    end
  end

  def show
    @project_user = ProjectUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project_user }
    end
  end

  def new
    @project_user = ProjectUser.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project_user }
    end
  end

  def edit
    @project_user = ProjectUser.find(params[:id])
  end

  def create
    @project_user = ProjectUser.new(params[:project_user])

    respond_to do |format|
      if @project_user.save
        flash[:notice] = 'ProjectUser was successfully created.'
        format.html { redirect_to(@project_user) }
        format.xml  { render :xml => @project_user, :status => :created, :location => @project_user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @project_user = ProjectUser.find(params[:id])

    respond_to do |format|
      if @project_user.update_attributes(params[:project_user])
        flash[:notice] = 'ProjectUser was successfully updated.'
        format.html { redirect_to(@project_user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @project_user = ProjectUser.find(params[:id])
    @project_user.destroy

    respond_to do |format|
      format.html { redirect_to(project_users_url) }
      format.xml  { head :ok }
    end
  end

  protected
    def authorized?
      logged_in? && current_user.is_admin
    end
end
