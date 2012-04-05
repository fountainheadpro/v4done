### GIVEN ###
Given /^I found some interesting goal$/ do
  @publication = Factory.create(:publication)
  visit publication_path(@publication)
end

### WHEN ###
When /^I provide my email address$/ do
  within('#send-to-actions') do
    fill_in 'email_or_phone_number', with: current_email_address
    click_button 'Get!'
  end
end

### THEN ###
Then /^I should receive email with link to todo\-list$/ do
  mailbox_for(current_email_address).size.should == 1
  open_email(current_email_address)
  current_email.subject.should =~ Regexp.new(@publication.template.title)
  current_email.body.should =~ Regexp.new(project_path(Project.where(publication_id: @publication.id).first))
end