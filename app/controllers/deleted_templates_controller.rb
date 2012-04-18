class DeletedTemplatesController < ApplicationController
  before_filter :authenticate_user!

  # GET /deleted_templates
  def index
    @templates = current_user.templates.deleted
  end

  # GET /deleted_templates/1
  def show
    @template = current_user.templates.deleted.find(params[:id])
  end

  # POST /deleted_templates/1/restore
  def restore
    @template = current_user.templates.deleted.find(params[:id])
    @template.restore
    redirect_to(templates_path + "##{@template.id}/items")
  end
end