class Export::ActionsController < ApplicationController
  def create
    if Export::Actions.import(params)
      redirect_to publication_url(params[:publication_id]), notice: "We send you link, check your phone"
    else
      redirect_to publication_url(params[:publication_id]), alert: "Something serious happened"
    end
  end
end
