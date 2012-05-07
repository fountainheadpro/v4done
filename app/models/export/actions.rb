class Export::Actions
  def self.export(params)
    if Publication.exists?(conditions: { id: params[:publication_id] }) && valid?(params[:email_or_phone_number])
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

  def self.valid?(email_or_phone_number)
    unless email_or_phone_number.blank?
      unless email_or_phone_number =~ /@/
        phone_number = email_or_phone_number.scan(/\d+/i).join
        phone_number.length >= 10 && phone_number[/^.\d+$/]
      end
    end
  end
end