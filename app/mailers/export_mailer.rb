class ExportMailer < ActionMailer::Base
  default from: "subscription@actions-im.mailgun.org"

  def actions(project)
    @project = project
    mail to: project.owner[:email] || project.owner['email'], subject: project.title
  end
end
