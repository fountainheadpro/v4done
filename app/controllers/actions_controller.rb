class ActionsController < ApplicationController
  layout 'actions'
  #respond_to :html, :only => [:index]
  respond_to :json, :only => [:index]

  # GET /projects/1/actions
  def index
    @project = Project.find(params[:project_id])
    #if params[:action_id].nil?
    #  @actions = @project.actions.roots
    #else
    #  @parent_action = @project.actions.find(params[:action_id])
    #  @actions = @parent_action.children
    #end
    #respond_with([@project, @actions])
    @project
  end
end
