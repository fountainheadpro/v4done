### GIVEN ###
Given /^I found some interesting goal$/ do
  @publication = FactoryGirl.create(:publication)
  visit publication_path(@publication)
end

### WHEN ###
When /^I provide my ([^"]*)$/ do |address|
  within('#send-to-actions') do
    if address =~ /email address/
      fill_in 'email_or_phone_number', with: current_email_address
    elsif address =~ /phone number/
      fill_in 'email_or_phone_number', with: current_phone_number
    end
    click_button 'Get!'
  end
end

### THEN ###
Then /^I should receive email with link to todo\-list$/ do
  mailbox_for(current_email_address).size.should == 1
  open_email(current_email_address)
  current_email.subject.should =~ Regexp.new(@publication.template.title)
  current_email.body.should =~ Regexp.new(path_to_current_project)
end

Then /^I should receive sms with link to todo\-list$/ do
  sms_for(current_phone_number).count.should == 1
  sms_for(current_phone_number).first[:message].should =~ Regexp.new(path_to_current_project)
end