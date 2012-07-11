class Export::Actions
  def self.export(params)
    pub_found=Publication.exists?(conditions: { id: params[:publication_id] })
    owner=owner(params[:email_or_phone_number])
    if pub_found && owner.present?
      publication = Publication.find params[:publication_id]
      project = Project.create_from_publication publication, owner
      project if project.valid?
    else
     raise "Publication not found" unless Publication.exists?(conditions: { id: params[:publication_id] })
     raise "invalid email: #{params[:email_or_phone_number]} " unless owner.present?
    end
  end

  private
  def self.owner(email_or_phone_number)
    email_or_phone_number ||= ''
    email_or_phone_number.try(:strip!)
    phone=clean_phone(email_or_phone_number)
    if email_or_phone_number =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
      { owner: { 'email' => email_or_phone_number } }
    elsif !phone.blank?
      phone=clean_phone(email_or_phone_number)
      { owner: { 'phone_number' => phone }}
    else
      {}
    end
  end

  def self.clean_phone(phone_number)
    clean_number = phone_number.to_s.gsub(/\D/,"")
    if (clean_number.to_s.length==11 && clean_number.to_s[0]=="1")
       return clean_number
    elsif (clean_number.to_s.length==10)
       return "1#{clean_number}"
    end
    return nil
  end

  def self.valid?(email_or_phone_number)
    unless email_or_phone_number.blank?
      unless email_or_phone_number =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
        phone_number = email_or_phone_number.scan(/\d+/i).join
        phone_number.length >= 10 && phone_number[/^.\d+$/]
      else
        true
      end
    end
  end


end