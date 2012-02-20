### THEN ###
Then /^I should see breadcrumbs: (.*)$/ do |breadcrumbs|
  find(".breadcrumb").text.should == case breadcrumbs
                                     when 'root element without separator'
                                       "Goals"
                                     when 'root element'
                                       "Goals /"
                                     when 'root element, title of the template'
                                       "Goals / #{@template.title} /"
                                     when 'root element, title of the template, title of the parent item'
                                       "Goals / #{@template.title} / #{@parent_item.title} /"
                                     end
end
