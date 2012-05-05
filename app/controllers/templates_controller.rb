class TemplatesController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :only => [:index]
  respond_to :json

  # GET /templates
  # GET /templates.json
  def index
    respond_with(@templates = current_user.templates.only(:title, :description, :updated_at).asc(:updated_at).entries)
  end

  # GET /templates/1.json
  def show
    respond_with(template = current_user.templates.find(params[:id]))
  end

  # POST /templates.json
  def create
    respond_with(template = current_user.templates.create(params[:template]))
  end

  # PUT /templates/1.json
  def update
    template = current_user.templates.find(params[:id])
    template.update_attributes params[:template].slice(:title, :description)
    respond_with(template)
  end

  # DELETE /templates/1.json
  def destroy
    template = current_user.templates.find(params[:id])
    template.destroy
    respond_with(template)
  end

end
