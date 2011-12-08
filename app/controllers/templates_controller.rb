class TemplatesController < ApplicationController
  before_filter :authenticate_user!

  # GET /templates
  # GET /templates.json
  def index
    @templates = current_user.templates.asc(:updated_at)
    @template = Template.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @templates }
    end
  end

  # GET /templates/1
  # GET /templates/1.json
  def show
    @template = Template.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @template }
    end
  end

  # POST /templates
  # POST /templates.json
  def create
    @template = Template.new(params[:template].merge({:creator => current_user}))

    respond_to do |format|
      if @template.save
        format.html { redirect_to templates_url, notice: 'Template was successfully created.' }
        format.json { render json: @template, status: :created, location: @template }
      else
        format.html { redirect_to templates_url }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /templates/1
  # PUT /templates/1.json
  def update
    @template = Template.find(params[:id])

    respond_to do |format|
      if @template.update_attributes(params[:template])
        format.html { redirect_to @template, notice: 'Template was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /templates/1
  # DELETE /templates/1.json
  def destroy
    @template = Template.find(params[:id])
    @template.destroy

    respond_to do |format|
      format.html { redirect_to templates_url }
      format.json { head :ok }
    end
  end
end
