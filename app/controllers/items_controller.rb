class ItemsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  # POST /templates/:template_id/items.json
  def create
    template = current_user.templates.find(params[:template_id])
    respond_with([template, item = template.items.create(params[:item])])
  end
end
