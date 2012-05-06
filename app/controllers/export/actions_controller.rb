class Export::ActionsController < ApplicationController
  def create
    if project = Export::Actions.export(params)
      send_link project
      redirect_to publication_url(params[:publication_id]), notice: "We send you link, check your phone"
    else
      redirect_to publication_url(params[:publication_id]), alert: "Something serious happened"
    end
  end

  private
  def send_link(project)
    if !project.owner['email'].blank?
      ExportMailer.actions(project).deliver
    elsif !project.owner['phone_number'].blank?
      Moonshado::Sms.new(project.owner['phone_number'], project_url(project)).deliver_sms
    end
  end
end
