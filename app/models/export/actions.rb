class Export::Actions
  def self.export(params)
    if Publication.exists?(conditions: { id: params[:publication_id] })
      publication = Publication.find params[:publication_id]
      project = Project.create_from_publication publication, owner(params[:email_or_phone_number])
      project if project.valid?
    end
  end

  private
  def self.owner(email_or_phone_number)
    email_or_phone_number ||= ''
    email_or_phone_number.try(:strip!)
    if email_or_phone_number =~ /@/
      { owner: { 'email' => email_or_phone_number } }
    elsif !email_or_phone_number.blank?
      { owner: { 'phone_number' => email_or_phone_number } }
    else
      {}
    end
  end
end