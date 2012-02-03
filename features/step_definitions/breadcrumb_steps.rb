### THEN ###

Then /^I should see breadcrumbs: root element without separator$/ do
  find(".breadcrumb").text.should == "Templates"
end

Then /^I should see breadcrumbs: root element$/ do
  find(".breadcrumb").text.should == "Templates /"
end

Then /^I should see breadcrumbs: root element, title of the template$/ do
  find(".breadcrumb").text.should == "Templates / #{@template.title} /"
end

Then /^I should see breadcrumbs: root element, title of the template, title of the parent item$/ do
  find(".breadcrumb").text.should == "Templates / #{@template.title} / #{@parent_item.title} /"
end