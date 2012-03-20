class ActionsController < ApplicationController
  layout 'actions'
  respond_to :html, :only => [:index]

  # GET /projects/1/actions
  def index
    @project = Project.find(params[:project_id])
    @actions = @project.actions.roots
    respond_with([@project, @actions])
  end
end
