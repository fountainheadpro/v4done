### GIVEN ###
Given /^I have few templates$/ do
  valid_templates.each do |title|
    current_user.templates.create title: title
  end
end

Given /^another user exists$/ do
  @another_user = User.create! valid_user.merge(name: "James Bond", email: "james.bond@example.com")
end

Given /^he have few templates too$/ do
  valid_templates.each do |title|
    @another_user.templates.create title: "#{title}!!!"
  end
end

### WHEN ###
When /^I look at the list of templates$/ do
  visit '/templates'
end

When /^I create new template$/ do
  visit '/templates'
  within("#new-template") do
    fill_in "title", with: 'Banana Pie'
    click_button "Create Template"
  end
end

### THEN ###
Then /^I should see all my templates$/ do
  valid_templates.each do |title|
    find("#templates").should have_content(title)
  end
end

Then /^I should not see his templates$/ do
  valid_templates.each do |title|
    find("#templates").should_not have_content("#{title}!!!")
  end
end

Then /^I should see this template$/ do
  find("#templates").should have_content("Banana Pie")
  Template.should exist(conditions: { title: "Banana Pie" })
end