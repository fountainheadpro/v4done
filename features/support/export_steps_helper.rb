module ExportStepsHelpers
  def current_email_address
    last_email_address || "example@example.com"
  end

  def current_phone_number
    '0123456789'
  end

  def path_to_current_project
    project_actions_path(Project.where(publication_id: @publication.id).first)
  end

  def sms_for(phone_number)
    Moonshado::Sms.delivered_sms[phone_number]
  end
end

World(ExportStepsHelpers)