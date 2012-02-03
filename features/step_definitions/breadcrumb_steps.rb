### THEN ###
Then /^I should see breadcrumbs: (.*)$/ do |breadcrumbs|
  find(".breadcrumb").text.should == case breadcrumbs
                                     when 'root element without separator'
                                       "Templates"
                                     when 'root element'
                                       "Templates /"
                                     when 'root element, title of the template'
                                       "Templates / #{@template.title} /"
                                     when 'root element, title of the template, title of the parent item'
                                       "Templates / #{@template.title} / #{@parent_item.title} /"
                                     end
end
