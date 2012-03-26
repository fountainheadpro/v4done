class ExportMailer < ActionMailer::Base
  default from: "subscription@actions.im"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.export_mailer.actions.subject
  #
  def actions(project)
    @project = project
    mail to: project.owner[:email] || project.owner['email'], subject: project.title
  end
end
