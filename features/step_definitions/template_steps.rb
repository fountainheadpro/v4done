### GIVEN ###
Given /^I have few templates$/ do
  @templates = FactoryGirl.create_list(:template, 3, creator: current_user)
end

Given /^another user exists$/ do
  @another_user = User.create! valid_user.merge(name: "James Bond", email: "james.bond@example.com")
end

Given /^he have few templates too$/ do
  @templates = FactoryGirl.create_list(:template, 3, creator: @another_user)
end

Given /^I have the template with items and subitems$/ do
  @template = Factory.create(:template_with_subitems, creator: current_user)
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

When /^I look at this template$/ do
  visit_template(@template)
end

When /^I look at the item of this template$/ do
  @item = @template.items.where(parent_id: nil).first
  visit_item(@item)
end

When /^I look at some subitem of this template$/ do
  @parent_item = @template.items.roots.first
  visit_item(@parent_item.children.first)
end

When /^I create new item in this template$/ do
  visit_template(@template)
  @title = "Footnotes"
  within(".new_item") do
    fill_in "title", with: @title
    keydown(".new_item textarea:first", :enter)
  end
end

When /^I create new item after first one$/ do
  visit_template(@template)
  @title = "Some text"
  keydown("#items .item:first textarea:first", :enter)
  find('#items .new_item').fill_in('title', with: @title)
  keydown("#items .new_item:first textarea:first", :enter)
end

When /^I create new subitem for some item in this template$/ do
  @item = @template.items.roots.first
  visit_item(@item)
  @title = "New subitem"
  within(".new_item") do
    fill_in "title", with: @title
    keydown(".new_item textarea:first", :enter)
  end
end

When /^I create new subitem after first one for some item in this template$/ do
  @item = @template.items.roots.first
  visit_item(@item)
  @title = "New second subitem"
  keydown("#items .item:first textarea:first", :enter)
  find('#items .new_item').fill_in('title', with: @title)
  keydown("#items .new_item:first textarea:first", :enter)
end

When /^refresh page$/ do
  page.driver.browser.execute_script('location.reload();')
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

Then /^I should see that items$/ do
  @template.items.where(parent_id: nil).each do |item|
    find("#items").should have_content(item.title)
  end
end

Then /^I should see that subitems$/ do
  @item.children.each do |item|
    find("#items").should have_content(item.title)
  end
end

Then /^I should see this (?:|sub)item$/ do
  find("#items").should have_content(@title)
  @template.reload
  @template.items.where(title: @title).should exist
end

Then /^I should see this new (?:|sub)item as second$/ do
  find('#items .item:nth-child(2)').should have_content(@title)
  @template.reload
  @template.items.where(title: @title).should exist
end