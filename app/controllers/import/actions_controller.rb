class Import::ActionsController < ApplicationController
  def create
    publication = Publication.find(params[:publication_id])
    project = Project.create_from_publication(publication)
    if project.valid?
      redirect_to project_actions_url(project)
    else
      redirect_to publication_url(publication), alert: "Something serious happened"
    end
  end
end
