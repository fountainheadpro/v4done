class PublicationsController < ApplicationController
  respond_to :html, :json
  before_filter :authenticate_user!, only: [:index, :create]
  before_filter :find_template, only: [:index, :create]

  # GET  /templates/1/publications.html
  def index
    respond_with(@publications = @template.publications)
  end

  # POST /templates/1/publications.html
  def create
    @publication = @template.publication
    if @publication.blank?
      @publication = current_user.publications.create template: { title: @template.title, description: @template.description, created_at: @template.created_at, updated_at: @template.updated_at, items: @template.active_items }
    else
      @publication.update_attributes template: { title: @template.title, description: @template.description, updated_at: @template.updated_at, items: @template.active_items }
      #Publication.collection.find_and_modify(:query => { "_id" => @publication.id }, :update=>@publication.attributes.merge({:template => @template.attributes}) )
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
