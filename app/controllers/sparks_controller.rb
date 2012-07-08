class SparksController < ApplicationController
  before_filter :authenticate_user!
  layout 'sparks'
  respond_to :json, :only => [:update]


  # GET /sparks/1
  def show
    @spark = current_user.sparks.find(params[:id])
  end

  def create
    respond_with(spark = current_user.sparks.create(params[:spark]))
  end


  def new

  end

end
