class ItemsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_template
  before_filter :find_item, only: [:update, :destroy]
  respond_to :json

  def index
    items = @template.active_items
    respond_with(@template, items)
  end

  # POST /templates/1/items.json
  def create
    item = @template.items.create(params[:item])
    respond_with(@template, item)
  end

  # PUT /templates/1/items.json
  def update
    @item.update_attributes(params[:item])
    respond_with(@item)
  end

  # DELETE /templates/1/items/1.json
  def destroy
    @item.destroy
    respond_with(@item)
  end

private

  def find_template()
    @template = current_user.templates.find(params[:template_id])
  end

  def find_item()
    @item = @template.items.find(params[:id])
  end
end
