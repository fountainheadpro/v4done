class PublicationsController < ApplicationController
  respond_to :html, :json
  before_filter :authenticate_user!, only: [:create]
  before_filter :find_template, only: [:create]

  # GET  /users/1/publications
  def index
    respond_with(@publications = current_user.publications.desc(:updated_at))
  end

  # POST /templates/1/publications.html
  def create
    @publication = @template.publication
    template_attributes = @template.attributes.merge("items" => @template.active_items.entries)
    if @publication.blank?
      @publication = current_user.publications.create template: template_attributes
    else
      @publication.update_attributes template: template_attributes
    end
    respond_with(@publication)
  end

  # GET /publications/1.html
  def show
    @publication = Publication.find(params[:id])
    @page_title = "#{@publication.template.title} - actions.im"
    respond_with(@publication)
  end

private
  def find_template
    @template = current_user.templates.find(params[:template_id])
  end
end
