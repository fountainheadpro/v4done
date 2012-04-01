class Export::Actions
  def self.export(params)
    if Publication.exists?(conditions: { id: params[:publication_id] })
      publication = Publication.find params[:publication_id]
      project = Project.create_from_publication publication, owner(params[:email_or_phone_number])
      send_link project
      project.valid?
    end
  end

  def self.send_link(project)
    if project.valid? && !project.owner.nil?
      if !project.owner['email'].blank?
        ExportMailer.actions(project).deliver
      elsif !project.owner['phone_number'].blank?
        host = case ENV['RAILS_ENV']
        when "production"
          "actions.im"
        when "development"
          "localhost:3000"
        when "test"
          "test.org"
        end
        Moonshado::Sms.new(project.owner['phone_number'], Rails.application.routes.url_helpers.project_actions_url(project, host: host)).deliver_sms
      end
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