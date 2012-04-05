module ExportStepsHelpers
  def current_email_address
    last_email_address || "example@example.com"
  end

  def current_phone_number
    '0123456789'
  end

  def path_to_current_project
    project_path(Project.where(publication_id: @publication.id).first)
  end
end

World(ExportStepsHelpers)