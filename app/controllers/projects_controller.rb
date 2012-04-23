class ProjectsController < ApplicationController
  layout 'actions'
  respond_to :json, :only => [:show]

  # GET /projects/1.js
  def show
    @project = Project.find(params[:id])
  end
end
