class Export::Actions
  def self.import(params)
    publication = Publication.find(params[:publication_id])
    project = Project.create_from_publication(publication, owner: { email: params[:email_or_phone_number] })
    if project.valid?
      ExportMailer.actions(project).deliver
    end
  end
end