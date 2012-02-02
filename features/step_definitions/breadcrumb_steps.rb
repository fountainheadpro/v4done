### THEN ###

Then /^I should see breadcrumbs: root element without separator$/ do
  find(".breadcrumb").should have_content("Templates")
end

Then /^I should see breadcrumbs: root element$/ do
  find(".breadcrumb").should have_content("Templates /")
end