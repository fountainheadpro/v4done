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
    @publication = Publication.where({ "template._id" => BSON::ObjectId(params[:template_id]) }).order_by([:created_at, :desc]).limit(1).first
    if @publication.blank?
      @publication = current_user.publications.create(template: @template)
    else
      @publication.update_attribute :template, @template.attributes
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
