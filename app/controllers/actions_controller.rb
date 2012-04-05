class ActionsController < ApplicationController
  layout 'actions'
  respond_to :json, :only => [:update]

  # PUT /actions/1/action.json
  def update
    @action = Project.find(params[:project_id]).actions.find(params[:id])
    @action.update_attributes(params[:action])
    respond_with(@action)
  end

end
