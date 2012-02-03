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

Given /^I have the template with items and subitems$/ do
  @template = current_user.templates.create title: 'Apple Pie'
  item = @template.items.create title: 'Ingredients'
  @template.items.create title: '1 recipe pastry for a 9 inch double crust pie', parent_id: item.id
  @template.items.create title: '1/2 cup unsalted butter', parent_id: item.id
  @template.items.create title: '3 tablespoons all-purpose flour', parent_id: item.id
  @template.items.create title: '1/4 cup water', parent_id: item.id
  @template.items.create title: '1/2 cup white sugar', parent_id: item.id
  @template.items.create title: '1/2 cup packed brown sugar', parent_id: item.id
  @template.items.create title: '8 Granny Smith apples - peeled, cored and sliced', parent_id: item.id
  @template.items.create title: 'Directions'
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
  @subitem =  @template.items.excludes(parent_id: nil).first
  @parent_item = @subitem.parent_item
  visit_item(@subitem)
end

When /^I create new item in this template$/ do
  visit_template(@template)
  @title = "Footnotes"
  within(".new_item") do
    fill_in "title", with: @title
    keydown(".new_item textarea:first", :enter)
  end
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

Then /^I should see this item$/ do
  find("#items").should have_content(@title)
  @template.reload
  @template.items.where(title: @title).should exist
end