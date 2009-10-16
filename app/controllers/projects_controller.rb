class ProjectsController < ApplicationController
  layout "admin"

  before_filter :login_required, :get_project_status

  # GET /projects
  # GET /projects.xml
  def index
    @expanded_project = Project.find( params[:expanded_project_id] ) if params[:expanded_project_id]
    if params[:client_id]
      @client = Client.find(params[:client_id])
      if current_user.is_admin || current_user.belongs_to_client?(@client.id)
        @closed_projects = @client.closed_projects if @project_status == 'closed'

        respond_to do |format|
          format.html # index.html.erb
          format.xml  { render :xml => @projects }
        end
      else
        redirect_to new_session_path
      end
    else
      redirect_to new_session_path
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])

    if current_user.is_admin || current_user.belongs_to_client?(@project.client_id)
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @project }
        format.js   {
          if params[:collapser]
            render :partial => "collapsed_project", :object => @project, :locals => { :project_status => @project_status }
          else
            render :partial => "expanded_project", :object => @project, :locals => { :project_status => @project_status }
          end
        }
      end
    else
      redirect_to new_session_path
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    if current_user.is_admin
      @project = Project.find(params[:id])
    else
      redirect_to new_session_path
    end
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])

    if current_user.is_admin || current_user.belongs_to_client?(@project.client_id)
      respond_to do |format|
        if @project.save
          current_user.alerts.create(
            :action_statement => "created a project",
            :client_id => @project.client.id,
            :project_id => @project.id
          )
          flash.now[:notice] = 'Project was successfully created.'
          format.html { redirect_to(@project) }
          format.xml  { render :xml => @project, :status => :created, :location => @project }
          format.js   { render :partial => "/projects/projects_client", :object => @project.client, :locals => { :expanded_project => @project, :project_status => @project_status } }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
          format.js   { render :partial => "/projects/projects_client", :object => @project.client, :locals => { :expanded_project => @project, :project_status => @project_status } }
        end
      end
    else
      redirect_to new_session_path
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    if params[:id]
      if current_user.is_admin
        @project = Project.find(params[:id])

        respond_to do |format|
          if @project.update_attributes(params[:project])
            current_user.alerts.create(
              :action_statement => "closed a project",
              :client_id => @project.client.id,
              :project_id => @project.id
            ) if @project.close_me
            flash[:notice] = 'Project was successfully updated.'
            format.html { redirect_to(@project) }
            format.xml  { head :ok }
            format.js   { render :partial => "/projects/projects_client", :object => @project.client, :locals => { :expanded_project => @project, :project_status => @project_status } }
          else
            format.html { render :action => "edit" }
            format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
            format.js   { render :partial => "/projects/projects_client", :object => @project.client, :locals => { :expanded_project => @project, :project_status => @project_status } }
          end
        end
      else
        redirect_to new_session_path
      end
    else
      client_id = nil
      (1..3).each do |urgency|
        params["projects_urgency_" + urgency.to_s].each_with_index do |id, position|
          project = Project.update(id, :priority => position)
          client_id = project.client.id # grab the client id to create the alert
        end if params["projects_urgency_" + urgency.to_s]
      end
      current_user.alerts.create(
        :action_statement => "updated the priority of projects",
        :client_id => client_id
      ) if client_id
      render :partial => "/projects/projects_client", :object => Client.find(client_id), :locals => { :expanded_project => false, :project_status => @project_status }
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    if current_user.is_admin
      @project = Project.find(params[:id])
      @project.destroy

      respond_to do |format|
        format.html { redirect_to(projects_url) }
        format.xml  { head :ok }
      end
    else
      redirect_to new_session_path
    end
  end

  protected
    def get_project_status
      if( params[:project_status] && params[:project_status] == 'closed' )
        @project_status = 'closed'
      else
        @project_status = 'open'
      end
    end
end
