class PublicationsController < ApplicationController
  respond_to :html
  before_filter :authenticate_user!, only: [:index, :create]
  before_filter :find_template, only: [:index, :create]

  # GET  /templates/1/publications.html
  def index
    respond_with(@publications = @template.publications)
  end

  # POST /templates/1/publications.html
  def create
    respond_with(@publication = current_user.publications.create(template: @template))
  end

  # GET /publications/1.html
  def show
    respond_with(@publication = Publication.find(params[:id]))
  end

private
  def find_template
    @template = current_user.templates.find(params[:template_id])
  end
end
