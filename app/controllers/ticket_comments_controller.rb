class TicketCommentsController < ApplicationController

  layout "admin"

  before_filter :login_required

  # GET /ticket_comments
  # GET /ticket_comments.xml
  def index
    if current_user.is_admin
      @ticket_comments = TicketComment.all

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @ticket_comments }
      end
    else
      redirect_to new_session_path
    end
  end

  # GET /ticket_comments/1
  # GET /ticket_comments/1.xml
  def show
    @ticket_comment = TicketComment.find(params[:id])

    if current_user.is_admin || current_user.belongs_to_client?(@ticket_comment.ticket.project.client_id)
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @ticket_comment }
      end
    else
      redirect_to new_session_path
    end
  end

  # GET /ticket_comments/new
  # GET /ticket_comments/new.xml
  def new
    @ticket_comment = TicketComment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ticket_comment }
    end
  end

  # GET /ticket_comments/1/edit
  def edit
    if current_user.is_admin
      @ticket_comment = TicketComment.find(params[:id])
    else
      redirect_to new_session_path
    end
  end

  # POST /ticket_comments
  # POST /ticket_comments.xml
  def create
    @ticket_comment = TicketComment.new(params[:ticket_comment])

    if current_user.is_admin || current_user.belongs_to_client?(@ticket_comment.ticket.project.client_id)
      respond_to do |format|
        if @ticket_comment.save
          current_user.alerts.create(
            :action_statement => "added a comment",
            :client_id => @ticket_comment.ticket.project.client.id,
            :project_id => @ticket_comment.ticket.project.id,
            :ticket_id => @ticket_comment.ticket.id,
            :ticket_comment_id => @ticket_comment.id
          )
          flash[:notice] = 'TicketComment was successfully created.'
          format.html { redirect_to(@ticket_comment) }
          format.xml  { render :xml => @ticket_comment, :status => :created, :location => @ticket_comment }
          format.js   { render :partial => '/projects/projects_client', :object => @ticket_comment.ticket.project.client, :locals => { :expanded_project => @ticket_comment.ticket.project } }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @ticket_comment.errors, :status => :unprocessable_entity }
          format.js   { render :partial => '/projects/projects_client', :object => @ticket_comment.ticket.project.client, :locals => { :expanded_project => @ticket_comment.ticket.project } }
        end
      end
    else
      redirect_to new_session_path
    end
  end

  # PUT /ticket_comments/1
  # PUT /ticket_comments/1.xml
  def update
    if current_user.is_admin
      @ticket_comment = TicketComment.find(params[:id])

      respond_to do |format|
        if @ticket_comment.update_attributes(params[:ticket_comment])
          flash[:notice] = 'TicketComment was successfully updated.'
          format.html { redirect_to(@ticket_comment) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @ticket_comment.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to new_session_path
    end
  end

  # DELETE /ticket_comments/1
  # DELETE /ticket_comments/1.xml
  def destroy
    @ticket_comment = TicketComment.find(params[:id])
    if current_user.is_admin || @ticket_comment.user == current_user
      @ticket_comment.destroy

      respond_to do |format|
        format.html { redirect_to(ticket_comments_url) }
        format.xml  { head :ok }
      end
    else
      redirect_to new_session_path
    end
  end
end
