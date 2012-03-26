module EmailStepsHelpers
  def current_email_address
    last_email_address || "example@example.com"
  end
end

World(EmailStepsHelpers)