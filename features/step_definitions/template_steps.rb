### GIVEN ###
Given /^I have few templates$/ do
  create_templates(current_user)
end

Given /^another user exists$/ do
  @another_user = User.create! valid_user.merge(name: "James Bond", email: "james.bond@example.com")
end

Given /^he have few templates too$/ do
  create_templates(@another_user)
end

### WHEN ###
When /^I look at the list of templates$/ do
  visit '/templates'
end

When /^I create new template$/ do
  visit '/templates'
  @title = 'Banana Pie'
  within("#new-template") do
    fill_in "title", with: @title
    click_button "Create Template"
  end
end

When /^I look at the this template$/ do
  visit '/templates'
  click_link @template.title
end

### THEN ###
Then /^I should see all my templates$/ do
  @templates.each do |template|
    find("#templates").should have_content(template.title)
  end
end

Then /^I should not see his templates$/ do
  @templates.each do |template|
    find("#templates").should_not have_content(template.title)
  end
end

Then /^I should see this template$/ do
  find("#templates").should have_content(@title)
  Template.should exist(conditions: { title: @title })
end