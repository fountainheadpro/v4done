### THEN ###
Then /^I should see breadcrumbs: (.*)$/ do |breadcrumbs|
  find(".breadcrumb").text.should == case breadcrumbs
                                     when 'title of the template'
                                       "#{@template.title} /"
                                     when 'title of the template, title of the parent item'
                                       "#{@template.title} / #{@parent_item.title} /"
                                     end
end
