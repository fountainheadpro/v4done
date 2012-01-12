class ItemsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  # POST /templates/1/items.json
  def create
    template = current_user.templates.find(params[:template_id])
    respond_with(template, item = template.items.create(params[:item]))
  end

  # DELETE /templates/1/items/1.json
  def destroy
    template = current_user.templates.find(params[:template_id])
    item = template.items.find(params[:id])
    item.destroy
    respond_with(template)
  end
end
